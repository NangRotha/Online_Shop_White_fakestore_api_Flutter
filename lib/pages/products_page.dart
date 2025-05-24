import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/product.dart';
import 'product_detail_page.dart';
import 'login_page.dart';
import 'main_screen.dart';
import 'edit_product_screen.dart';

class ProductsPage extends StatefulWidget {
  final Set<int> likedProducts;
  final Function(int) toggleLike;

  const ProductsPage({
    super.key,
    required this.likedProducts,
    required this.toggleLike,
  });

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  bool _loading = true;
  String? _error;
  String _searchQuery = '';
  String? _selectedCategory;
  List<String> _categories = ['ទាំងអស់']; // 'All'

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        _products = jsonList.map((json) => Product.fromJson(json)).toList();
        // Extract categories
        final Set<String> categorySet =
            _products.map((p) => p.category).toSet();
        setState(() {
          _categories.addAll(categorySet.toList()..sort());
          _filterProducts();
          _loading = false;
        });
      } else {
        setState(() {
          _error = 'បរាជ័យក្នុងការផ្ទុកផលិតផល: ${response.statusCode}'; // Failed to load products: ...
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'កំហុសបណ្តាញ: $e'; // Network error: ...
        _loading = false;
      });
    }
  }

  void _filterProducts() {
    setState(() {
      _filteredProducts = _products.where((product) {
        final titleMatch =
            product.title.toLowerCase().contains(_searchQuery.toLowerCase());
        final categoryMatch = _selectedCategory == null ||
            _selectedCategory == 'ទាំងអស់' || // 'All'
            product.category == _selectedCategory;
        return titleMatch && categoryMatch;
      }).toList();
    });
  }

  Future<void> _addProduct(BuildContext context) async {
    final newProduct = await Navigator.push<Product>(
      context,
      MaterialPageRoute(builder: (context) => const EditProductScreen()),
    );
    if (newProduct != null) {
      setState(() {
        _products.add(newProduct);
        _filterProducts();
      });
    }
  }

  Future<void> _editProduct(BuildContext context, Product product) async {
    final updatedProduct = await Navigator.push<Product>(
      context,
      MaterialPageRoute(builder: (context) => EditProductScreen(productToEdit: product)),
    );
    if (updatedProduct != null) {
      setState(() {
        final index = _products.indexWhere((p) => p.id == updatedProduct.id);
        if (index != -1) {
          _products[index] = updatedProduct;
          _filterProducts();
        }
      });
    }
  }

  Future<void> _deleteProduct(BuildContext context, dynamic productId) async {
    setState(() {
      _products.removeWhere((product) => product.id == productId);
      _filterProducts();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('ផលិតផលត្រូវបានលុប! (សាកល្បង)')), // Product deleted! (Simulated)
    );
  }

  void _viewProductDetail(BuildContext context, Product product) {
    Navigator.pushNamed(
      context,
      '/product_detail',
      arguments: {
        'product': product,
        'likedProducts': widget.likedProducts,
        'toggleLike': widget.toggleLike,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ផលិតផលរបស់យើង', style: TextStyle(fontFamily: 'Noto Sans Khmer')), // Our Products
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _addProduct(context),
            tooltip: 'បន្ថែមផលិតផល', // Add Product
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchProducts,
            tooltip: 'ធ្វើឱ្យទាន់សម័យផលិតផល', // Refresh Products
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.findAncestorStateOfType<MainScreenState>()?.clearLikedProducts();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            tooltip: 'ចាកចេញ', // Logout
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(90.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                      _filterProducts();
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'ស្វែងរកផលិតផល', // Search products
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _categories.map((category) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ChoiceChip(
                          label: Text(category == 'ទាំងអស់' ? 'ទាំងអស់' : category, // All : category
                              style: const TextStyle(fontFamily: 'Noto Sans Khmer')),
                          selected: _selectedCategory == category,
                          onSelected: (selected) {
                            setState(() {
                              _selectedCategory = selected ? category : null;
                              _filterProducts();
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, color: Colors.red, size: 50),
                        const SizedBox(height: 10),
                        Text('កំហុស: ${_error!}', // Error: ...
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.red, fontSize: 16, fontFamily: 'Noto Sans Khmer')),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _fetchProducts,
                          child: const Text('ព្យាយាមម្តងទៀត', style: TextStyle(fontFamily: 'Noto Sans Khmer')), // Try Again
                        ),
                      ],
                    ),
                  ),
                )
              : _filteredProducts.isEmpty
                  ? const Center(
                      child: Text('មិនមានផលិតផលត្រូវនឹងលក្ខណៈវិនិច្ឆ័យទេ។', // No products match the criteria.
                          style: TextStyle(fontSize: 16, fontFamily: 'Noto Sans Khmer')),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(8.0),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: _filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = _filteredProducts[index];
                        final isLiked = widget.likedProducts.contains(product.id);
                        return Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: InkWell(
                            onTap: () => _viewProductDetail(context, product),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(
                                      product.image,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress.expectedTotalBytes != null
                                                ? loadingProgress.cumulativeBytesLoaded /
                                                    loadingProgress.expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.title,
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Noto Sans Khmer'),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '\$${product.price.toStringAsFixed(2)}',
                                        style: TextStyle(color: Colors.green[700], fontFamily: 'Noto Sans Khmer'),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          isLiked ? Icons.favorite : Icons.favorite_border,
                                          color: isLiked ? Colors.red : Colors.grey[600],
                                        ),
                                        onPressed: () => widget.toggleLike(product.id),
                                        tooltip: isLiked ? 'ឈប់ចូលចិត្ត' : 'ចូលចិត្ត', // Unlike / Like
                                        iconSize: 20,
                                      ),
                                      PopupMenuButton<String>(
                                        onSelected: (value) {
                                          if (value == 'edit') {
                                            _editProduct(context, product);
                                          } else if (value == 'delete') {
                                            _deleteProduct(context, product.id);
                                          }
                                        },
                                        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                          const PopupMenuItem<String>(
                                            value: 'edit',
                                            child: Text('កែប្រែ', style: TextStyle(fontFamily: 'Noto Sans Khmer')), // Edit
                                          ),
                                          const PopupMenuItem<String>(
                                            value: 'delete',
                                            child: Text('លុប', style: TextStyle(fontFamily: 'Noto Sans Khmer')), // Delete
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}