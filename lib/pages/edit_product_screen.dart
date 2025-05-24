import 'package:flutter/material.dart';
import '../models/product.dart';

class EditProductScreen extends StatefulWidget {
  final Product? productToEdit;

  const EditProductScreen({super.key, this.productToEdit});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.productToEdit != null) {
      _titleController.text = widget.productToEdit!.title;
      _priceController.text = widget.productToEdit!.price.toString();
      _descriptionController.text = widget.productToEdit!.description;
      _categoryController.text = widget.productToEdit!.category;
      _imageController.text = widget.productToEdit!.image;
    }
  }

  Future<void> _saveProduct(BuildContext context) async {
    final title = _titleController.text;
    final price = double.tryParse(_priceController.text) ?? 0.0;
    final description = _descriptionController.text;
    final category = _categoryController.text;
    final image = _imageController.text;

    if (title.isNotEmpty &&
        description.isNotEmpty &&
        category.isNotEmpty &&
        image.isNotEmpty &&
        price > 0) {
      Product newOrUpdatedProduct = Product(
        id: widget.productToEdit?.id ?? DateTime.now().millisecondsSinceEpoch,
        title: title,
        price: price,
        description: description,
        category: category,
        image: image,
        rating: {'rate': 0.0, 'count': 0},
      );

      if (widget.productToEdit == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('ផលិតផលត្រូវបានបន្ថែម! (សាកល្បង)')), // Product added! (Simulated)
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('ផលិតផលត្រូវបានកែប្រែ! (សាកល្បង)')), // Product updated! (Simulated)
        );
      }
      Navigator.pop(context, newOrUpdatedProduct);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('សូមបំពេញគ្រប់ចន្លោះដោយទិន្នន័យត្រឹមត្រូវ។')), // Please fill all fields with valid data.
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productToEdit == null ? 'បន្ថែមផលិតផល' : 'កែប្រែផលិតផល', // Add Product / Edit Product
            style: const TextStyle(fontFamily: 'Noto Sans Khmer')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _titleController,
              style: const TextStyle(fontFamily: 'Noto Sans Khmer'),
              decoration: InputDecoration(
                labelText: 'ចំណងជើង', // Title
                labelStyle: const TextStyle(fontFamily: 'Noto Sans Khmer'),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _priceController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(fontFamily: 'Noto Sans Khmer'),
              decoration: InputDecoration(
                labelText: 'តម្លៃ', // Price
                labelStyle: const TextStyle(fontFamily: 'Noto Sans Khmer'),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _descriptionController,
              maxLines: 3,
              style: const TextStyle(fontFamily: 'Noto Sans Khmer'),
              decoration: InputDecoration(
                labelText: 'ការពិពណ៌នា', // Description
                labelStyle: const TextStyle(fontFamily: 'Noto Sans Khmer'),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _categoryController,
              style: const TextStyle(fontFamily: 'Noto Sans Khmer'),
              decoration: InputDecoration(
                labelText: 'ប្រភេទ', // Category
                labelStyle: const TextStyle(fontFamily: 'Noto Sans Khmer'),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _imageController,
              decoration: InputDecoration(
                labelText: 'URL រូបភាព', // Image URL
                labelStyle: const TextStyle(fontFamily: 'Noto Sans Khmer'),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _saveProduct(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                textStyle: const TextStyle(fontFamily: 'Noto Sans Khmer', fontSize: 18),
              ),
              child: const Text('រក្សាទុកផលិតផល'), // Save Product
            ),
          ],
        ),
      ),
    );
  }
}