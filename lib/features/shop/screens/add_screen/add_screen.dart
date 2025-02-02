import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/appbar/appbar.dart';
import 'package:gear_share_project/features/shop/controllers/category_controller.dart';
import 'package:gear_share_project/features/shop/models/product_model.dart';
import 'package:gear_share_project/features/shop/screens/home/home.dart';
import 'package:gear_share_project/features/shop/services/firebase_service.dart';
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

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  String? _selectedCategory;
  RentalPeriod? _selectedRentalPeriod;
  List<XFile>? _images;
  bool _isLoading = false;
  final FirebaseService _firebaseService = FirebaseService();
  final CategoryController _categoryController = Get.find();

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
      if (_images == null || _images!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select at least one image')),
        );
        return;
      }

      setState(() => _isLoading = true);

      try {
        final uid = FirebaseAuth.instance.currentUser?.uid;
        if (uid == null) throw 'User not authenticated';

        // Загружаем изображения
        List<String> imageUrls = [];
        for (var image in _images!) {
          final fileName =
              '${DateTime.now().millisecondsSinceEpoch}_${image.name}';
          debugPrint('Uploading image: $fileName');
          final url = await _firebaseService.uploadImage(
            File(image.path),
            fileName,
          );
          imageUrls.add(url);
        }

        debugPrint('All images uploaded successfully');

        // Создаем продукт
        final product = ProductModel(
          id: '',
          title: _titleController.text,
          description: _descriptionController.text,
          price: double.parse(_priceController.text),
          category: _selectedCategory ?? '',
          rentalPeriod: _selectedRentalPeriod.toString(),
          images: imageUrls,
          author: uid,
          status: "Dostępny",
          createdAt: DateTime.now(),
        );

        debugPrint('Creating product with data: ${product.toJson()}');
        await _firebaseService.createProduct(product);

        if (!mounted) return;
        setState(() => _isLoading = false);
        Get.to(() => const HomeScreen());
      } catch (e) {
        debugPrint('Error in _submitForm: $e');
        if (!mounted) return;
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
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
                    DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      decoration:
                          const InputDecoration(labelText: 'Kategoria *'),
                      items: _categoryController.categories
                          .where((category) => category.isActive)
                          .map((category) {
                        return DropdownMenuItem(
                          value: category.id,
                          child: Text(category.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
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
                          child: Text(period.displayName),
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
