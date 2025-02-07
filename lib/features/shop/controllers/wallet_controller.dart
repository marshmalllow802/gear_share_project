import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gear_share_project/common/widgets/loaders/loaders.dart';
import 'package:get/get.dart';

class WalletController extends GetxController {
  static WalletController get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final balance = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    getBalance();
  }

  Future<void> getBalance() async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) return;

      final doc = await _db.collection('Wallets').doc(userId).get();
      if (doc.exists) {
        balance.value = (doc.data()?['balance'] as num?)?.toDouble() ?? 0.0;
      } else {
        // Tworzymy portfel jeśli nie istnieje
        await _db.collection('Wallets').doc(userId).set({'balance': 0.0});
      }
    } catch (e) {
      print('Błąd podczas pobierania salda: $e');
    }
  }

  Future<void> addFunds(double amount) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) return;

      await _db.collection('Wallets').doc(userId).update({
        'balance': FieldValue.increment(amount),
      });

      balance.value += amount;
      KLoaders.successSnackBar(
        title: 'Sukces',
        message: 'Środki zostały dodane do portfela',
      );
    } catch (e) {
      KLoaders.errorSnackBar(
        title: 'Błąd',
        message: 'Nie udało się dodać środków',
      );
    }
  }

  Future<bool> processRental(
      String ownerId, double amount, String productId) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) return false;

      print('Rozpoczynam transakcję wypożyczenia:');
      print('- Od użytkownika: $userId');
      print('- Do użytkownika: $ownerId');
      print('- Kwota: $amount zł');

      // Sprawdź czy produkt nie jest już wypożyczony
      final existingRental = await _db
          .collection('RentedProducts')
          .where('productId', isEqualTo: productId)
          .where('status', isEqualTo: 'active')
          .get();

      if (existingRental.docs.isNotEmpty) {
        KLoaders.errorSnackBar(
          title: 'Błąd',
          message: 'Ten produkt jest już wypożyczony',
        );
        return false;
      }

      // Sprawdź status produktu
      final productDoc = await _db.collection('Products').doc(productId).get();
      if (productDoc.data()?['status'] != 'Dostępny') {
        KLoaders.errorSnackBar(
          title: 'Błąd',
          message: 'Ten produkt nie jest już dostępny',
        );
        return false;
      }

      if (balance.value < amount) {
        KLoaders.errorSnackBar(
          title: 'Niewystarczające środki',
          message: 'Doładuj swój portfel aby wypożyczyć produkt',
        );
        return false;
      }

      // Upewnienie się, że portfele istnieją przed transakcją
      final ownerWallet = await _db.collection('Wallets').doc(ownerId).get();
      if (!ownerWallet.exists) {
        await _db.collection('Wallets').doc(ownerId).set({
          'balance': 0.0,
          'lastUpdated': FieldValue.serverTimestamp(),
        });
      }

      // Wykonaj operację w jednej transakcji
      final success = await _db.runTransaction<bool>(((transaction) async {
        final userWalletRef = _db.collection('Wallets').doc(userId);
        final ownerWalletRef = _db.collection('Wallets').doc(ownerId);
        final productRef = _db.collection('Products').doc(productId);

        final userWalletDoc = await transaction.get(userWalletRef);
        final ownerWalletDoc = await transaction.get(ownerWalletRef);
        final productDoc = await transaction.get(productRef);

        if (productDoc.data()?['status'] != 'Dostępny') {
          return false;
        }

        final userBalance =
            (userWalletDoc.data()?['balance'] as num?)?.toDouble() ?? 0.0;
        final ownerBalance =
            (ownerWalletDoc.data()?['balance'] as num?)?.toDouble() ?? 0.0;

        if (userBalance < amount) {
          return false;
        }

        print('Salda przed transakcją:');
        print('- Wypożyczający ($userId): $userBalance zł');
        print('- Właściciel ($ownerId): $ownerBalance zł');

        // Wykonaj transfer
        transaction.update(userWalletRef, {
          'balance': userBalance - amount,
          'lastUpdated': FieldValue.serverTimestamp(),
        });

        transaction.update(ownerWalletRef, {
          'balance': ownerBalance + amount,
          'lastUpdated': FieldValue.serverTimestamp(),
        });

        // Zmień status produktu
        transaction.update(productRef, {
          'status': 'Wypożyczony',
          'lastUpdated': FieldValue.serverTimestamp(),
        });

        // Dodaj do wypożyczonych
        final rentedRef = _db.collection('RentedProducts').doc();
        transaction.set(rentedRef, {
          'productId': productId,
          'renterId': userId,
          'ownerId': ownerId,
          'rentedAt': FieldValue.serverTimestamp(),
          'amount': amount,
          'status': 'active',
        });

        print('Salda po transakcji:');
        print('- Wypożyczający: ${userBalance - amount} zł');
        print('- Właściciel: ${ownerBalance + amount} zł');

        return true;
      }));

      if (success) {
        balance.value -= amount;
        print('Transakcja zakończona sukcesem');
      }

      return success;
    } catch (e) {
      print('Błąd podczas przetwarzania płatności: $e');
      print('Stack trace: ${e.toString()}');
      KLoaders.errorSnackBar(
        title: 'Błąd',
        message: 'Nie udało się przetworzyć płatności',
      );
      return false;
    }
  }
}
