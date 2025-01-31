import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/appbar/appbar.dart';
import 'package:gear_share_project/features/shop/models/product_model.dart';
import 'package:gear_share_project/features/shop/screens/home/home.dart';
import 'package:gear_share_project/utils/constants/enums.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
/*  Future<String> uploadImage(String path, XFile image) async {
    try {
      // Logujemy wybraną ścieżkę do zdjęcia
      print("Przesyłanie zdjęcia do Firebase Storage: ${image.path}");

      // Tworzymy referencję do miejsca w Firebase Storage
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      final file = File(image.path);

      // Sprawdzamy, czy plik istnieje w systemie
      if (await file.exists()) {
        print("Plik istnieje, przesyłanie...");
      } else {
        print("Plik nie istnieje! Ścieżka: ${image.path}");
        return ''; // Jeśli plik nie istnieje, zwróć pusty string
      }

      // Przesyłanie zdjęcia do Firebase Storage
      final uploadTask = ref.putFile(file);
      uploadTask.snapshotEvents.listen((event) {
        print(
            "Przesyłanie: ${event.bytesTransferred} / ${event.totalBytes} bytes");
      });

      // Czekamy, aż operacja zakończy się sukcesem
      await uploadTask.whenComplete(() async {
        print("Zdjęcie zostało przesłane do Firebase Storage.");
      });

      // Uzyskiwanie URL po zakończeniu przesyłania
      final url = await ref.getDownloadURL();
      print("URL zdjęcia z Firebase Storage: $url");

      return url; // Zwracamy URL zdjęcia
    } on FirebaseException catch (e) {
      print("Błąd podczas przesyłania zdjęcia: $e");
      throw 'Coś poszło nie tak z przesyłaniem zdjęcia. Spróbuj ponownie.';
    }
  }*/

  final _db = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  PostCategory? _selectedCategory;
  RentalPeriod? _selectedRentalPeriod;
  List<XFile>? _images;
  bool _isLoading = false;

  /// Metoda do wyboru zdjęć
  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();
    setState(() {
      _images = pickedFiles;
    });
  }

  Future<void> _submitForm() async {
    if (!mounted) return;
    if (_formKey.currentState!.validate()) {
      /// Подготовка данных
      final title = _titleController.text;
      final description = _descriptionController.text;
      final price = double.tryParse(_priceController.text);
      final category = _selectedCategory;
      final rentalPeriod = _selectedRentalPeriod;
      final images = _images;

      /// Валидация
      if (title.isEmpty ||
          price == null ||
          category == null ||
          images == null ||
          images.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Proszę wypełnić wszystkie wymagane pola.')),
        );
        return;
      }

      try {
        // Получаем ID пользователя
        final uid = FirebaseAuth.instance.currentUser?.uid;
        final author = uid ?? "";

        // Устанавливаем состояние загрузки
        setState(() => _isLoading = true);

        // Загружаем все изображения и получаем их URL
        List<String> imagesUrls = [];
        for (var image in images) {
          final ref =
              FirebaseStorage.instance.ref("Images/Products").child(image.name);
          final file = File(image.path);

          // Загружаем файл
          await ref.putFile(file);

          // Получаем URL
          final url = await ref.getDownloadURL();
          imagesUrls.add(url);
        }

        // После загрузки всех изображений создаем продукт
        final newProduct = ProductModel(
            id: "",
            title: title,
            description: description,
            price: price,
            category: category.toString(),
            rentalPeriod: rentalPeriod.toString(),
            images: imagesUrls,
            author: author,
            status: "Dostępny");

        // Сохраняем продукт в Firestore
        await _db.collection("Products").add(newProduct.toJson());

        // Переходим на главный экран
        if (!mounted) return;
        setState(() => _isLoading = false);
        Get.to(() => const HomeScreen());
      } catch (e) {
        debugPrint("Error: $e");
        if (!mounted) return;
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Wystąpił błąd podczas dodawania produktu.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: KAppBar(
            title: Text(
              'Dodaj ogłoszenie',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            showBackArror: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: AbsorbPointer(
              // Блокируем взаимодействие во время загрузки
              absorbing: _isLoading,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Pole tytułu
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: 'Tytuł *'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Proszę podać tytuł.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Wybór kategorii
                    DropdownButtonFormField<PostCategory>(
                      value: _selectedCategory,
                      decoration:
                          const InputDecoration(labelText: 'Kategoria *'),
                      items: PostCategory.values.map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(
                              category.name), // .name odczytuje nazwę enuma
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Proszę wybrać kategorię.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Pole opisu
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 5,
                      decoration: const InputDecoration(labelText: 'Opis'),
                    ),
                    const SizedBox(height: 16),

                    // Pole ceny
                    TextFormField(
                      controller: _priceController,
                      decoration: const InputDecoration(labelText: 'Cena *'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || double.tryParse(value) == null) {
                          return 'Proszę podać poprawną cenę.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Wybór zdjęć
                    OutlinedButton.icon(
                      onPressed: _pickImages,
                      icon: const Icon(Icons.image),
                      label: const Text('Dodaj zdjęcia'),
                    ),
                    if (_images != null && _images!.isNotEmpty)
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: _images!.map((image) {
                          return Image.file(
                            File(image.path),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          );
                        }).toList(),
                      ),
                    const SizedBox(height: 16),

                    // Wybór okresu wypożyczenia
                    DropdownButtonFormField<RentalPeriod>(
                      value: _selectedRentalPeriod,
                      decoration: const InputDecoration(
                          labelText: 'Okres wypożyczenia'),
                      items: RentalPeriod.values.map((period) {
                        return DropdownMenuItem(
                          value: period,
                          child: Text(period.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedRentalPeriod = value;
                        });
                      },
                    ),
                    const SizedBox(height: 32),

                    // Przycisk do wysłania formularza
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        child: const Text('Dodaj ogłoszenie'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (_isLoading)
          Container(
            color: Colors.black26,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
