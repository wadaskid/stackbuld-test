import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:stackbuld/controllers/product_controller.dart';
import 'package:stackbuld/models/product.dart';

class AddProductDialog extends StatefulWidget {
  const AddProductDialog({super.key});

  @override
  AddProductDialogState createState() => AddProductDialogState();
}

class AddProductDialogState extends State<AddProductDialog> {
  final ProductController productController = Get.find();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;
  final List<String> _categories = [
    'Electronics',
    'Clothing',
    'Books',
    'Home',
    'Toys'
  ];
  String? _selectedCategory;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<String> _uploadImage(File image) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('product_images/${DateTime.now().toIso8601String()}.jpg');
    final uploadTask = storageRef.putFile(image);
    final snapshot = await uploadTask.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Product'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Description is required';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Price is required';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Enter a valid price';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Category'),
                value: _selectedCategory,
                items: _categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Category is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              _image != null
                  ? Image.file(_image!, height: 150)
                  : TextButton.icon(
                      onPressed: _pickImage,
                      icon: const Icon(Icons.image),
                      label: const Text('Pick Image'),
                    ),
              if (_isUploading) const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              if (_image != null) {
                setState(() {
                  _isUploading = true;
                });
                try {
                  final imageUrl = await _uploadImage(_image!);

                  final Product newProduct = Product(
                    id: '', // Firebase will generate the ID
                    name: nameController.text,
                    description: descriptionController.text,
                    price: double.parse(priceController.text),
                    category: _selectedCategory!,
                    imageUrl: imageUrl,
                  );

                  await productController.addProduct(newProduct);

                  Get.back(); // Close the dialog
                } catch (e) {
                  Get.snackbar('Error', 'Failed to upload image');
                } finally {
                  setState(() {
                    _isUploading = false;
                  });
                }
              } else {
                Get.snackbar('Error', 'Please select an image');
              }
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
