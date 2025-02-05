import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/appbar/appbar.dart';
import 'package:gear_share_project/features/shop/controllers/category_controller.dart';
import 'package:gear_share_project/features/shop/controllers/my_products_controller.dart';
import 'package:gear_share_project/utils/constants/colors.dart';
import 'package:gear_share_project/utils/constants/enums.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:get/get.dart';

import '../../models/product_model.dart';

class EditProductScreen extends StatefulWidget {
  final ProductModel product;

  const EditProductScreen({super.key, required this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final controller = MyProductsController.instance;
  final _formKey = GlobalKey<FormState>();
  final _categoryController = Get.find<CategoryController>();

  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final TextEditingController priceController;
  String? selectedCategory;
  RentalPeriod? selectedRentalPeriod;
  String? selectedStatus;
  bool _isLoading = false;

  final List<String> statusOptions = ['Dostępny', 'Wypożyczony', 'Niedostępny'];

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.product.title);
    descriptionController =
        TextEditingController(text: widget.product.description);
    priceController =
        TextEditingController(text: widget.product.price.toString());
    selectedCategory = widget.product.category;
    selectedRentalPeriod = RentalPeriod.values.firstWhere(
        (period) => period.displayName == widget.product.rentalPeriod,
        orElse: () => RentalPeriod.oneDay);
    selectedStatus = widget.product.status;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar(
        title: Text(
          'Edytuj ogłoszenie',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArror: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(KSizes.defaultSpace),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Zdjęcia produktu
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(KSizes.borderRadiusMd),
                  color: KColors.grey.withOpacity(0.1),
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.product.images.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        widget.product.images[index],
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: KSizes.spaceBtwItems),

              // Tytuł
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Tytuł *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Proszę podać tytuł.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: KSizes.spaceBtwItems),

              // Kategoria
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Kategoria *',
                  border: OutlineInputBorder(),
                ),
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
                    selectedCategory = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Proszę wybrać kategorię.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: KSizes.spaceBtwItems),

              // Opis
              TextFormField(
                controller: descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Opis',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: KSizes.spaceBtwItems),

              // Cena
              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Cena *',
                  border: OutlineInputBorder(),
                  suffixText: 'zł',
                ),
                validator: (value) {
                  if (value == null || double.tryParse(value) == null) {
                    return 'Proszę podać poprawną cenę.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: KSizes.spaceBtwItems),

              // Status
              DropdownButtonFormField<String>(
                value: selectedStatus,
                decoration: const InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                ),
                items: statusOptions.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedStatus = value;
                  });
                },
              ),
              const SizedBox(height: KSizes.spaceBtwItems),

              // Okres wypożyczenia
              DropdownButtonFormField<RentalPeriod>(
                value: selectedRentalPeriod,
                decoration: const InputDecoration(
                  labelText: 'Okres wypożyczenia',
                  border: OutlineInputBorder(),
                ),
                items: RentalPeriod.values.map((period) {
                  return DropdownMenuItem(
                    value: period,
                    child: Text(period.displayName),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedRentalPeriod = value;
                  });
                },
              ),
              const SizedBox(height: KSizes.spaceBtwSections),

              // Przycisk zapisz
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            final data = {
                              'title': titleController.text,
                              'description': descriptionController.text,
                              'price':
                                  double.tryParse(priceController.text) ?? 0.0,
                              'status': selectedStatus,
                              'rentalPeriod': selectedRentalPeriod?.displayName,
                              'category': selectedCategory,
                            };
                            controller.updateProduct(widget.product.id, data);
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(KSizes.md),
                    backgroundColor: KColors.primary,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Zapisz zmiany'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
