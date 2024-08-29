import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:stackbuld/controllers/product_controller.dart';
import 'package:stackbuld/models/product.dart';

class EditProductDialog extends StatefulWidget {
  final Product product;

  const EditProductDialog({super.key, required this.product});

  @override
  EditProductDialogState createState() => EditProductDialogState();
}

class EditProductDialogState extends State<EditProductDialog> {
  final ProductController productController = Get.find();

  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  late String? _selectedCategory;

  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product.name);
    descriptionController =
        TextEditingController(text: widget.product.description);
    priceController =
        TextEditingController(text: widget.product.price.toString());
    _selectedCategory = widget.product.category;
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImage(File image) async {
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
      title: const Text('Edit Product'),
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
                items: ['Electronics', 'Clothing', 'Books', 'Home', 'Toys']
                    .map((category) {
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
                  : widget.product.imageUrl.isNotEmpty
                      ? Image.network(widget.product.imageUrl, height: 150)
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
              String? imageUrl = widget.product.imageUrl;

              if (_image != null) {
                setState(() {
                  _isUploading = true;
                });
                try {
                  imageUrl = await _uploadImage(_image!);
                } catch (e) {
                  Get.snackbar('Error', 'Failed to upload image');
                } finally {
                  setState(() {
                    _isUploading = false;
                  });
                }
              }

              final Product updatedProduct = Product(
                id: widget.product.id,
                name: nameController.text,
                description: descriptionController.text,
                price: double.parse(priceController.text),
                category: _selectedCategory!,
                imageUrl: imageUrl!,
              );

              await productController.updateProduct(
                  widget.product.id, updatedProduct);

              Get.back(); // Close the dialog
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
