import 'package:flutter/material.dart';
import '../models/product.dart';
import 'payment_card_screen.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args == null || !args.containsKey('product')) {
      return Scaffold(
        appBar: AppBar(title: const Text('កំហុស', style: TextStyle(fontFamily: 'Noto Sans Khmer'))), // Error
        body: const Center(child: Text('ពត៌មានលំអិតផលិតផលមិនត្រូវបានរកឃើញ។', style: TextStyle(fontFamily: 'Noto Sans Khmer'))), // Product details not found.
      );
    }

    final Product product = args['product'] as Product;
    final Set<int> likedProducts = args['likedProducts'] as Set<int>;
    final Function(int) toggleLike = args['toggleLike'] as Function(int);

    final bool isLiked = likedProducts.contains(product.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title, style: const TextStyle(fontFamily: 'Noto Sans Khmer')),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Image.network(
                  product.image,
                  height: 300,
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox(
                      height: 300,
                      child: Center(child: Icon(Icons.broken_image, size: 80, color: Colors.grey)),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    product.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey[800],
                          fontFamily: 'Noto Sans Khmer',
                        ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : Colors.grey[600],
                    size: 30,
                  ),
                  onPressed: () => toggleLike(product.id),
                  tooltip: isLiked ? 'ឈប់ចូលចិត្ត' : 'ចូលចិត្ត', // Unlike / Like
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.green[700],
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Noto Sans Khmer',
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'ប្រភេទ: ${product.category}', // Category: ...
              style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey[700], fontFamily: 'Noto Sans Khmer'),
            ),
            const SizedBox(height: 16),
            Text(
              'ការពិពណ៌នា:', // Description:
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Noto Sans Khmer'),
            ),
            const SizedBox(height: 8),
            Text(
              product.description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5, fontFamily: 'Noto Sans Khmer'),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('បានបន្ថែមទៅក្នុងរទេះ! (មុខងារមិនទាន់អនុវត្ត)')), // Added to cart! (Functionality not implemented)
                        );
                      },
                      icon: const Icon(Icons.add_shopping_cart),
                      label: const Text('បន្ថែមទៅក្នុងរទេះ', style: TextStyle(fontSize: 18, fontFamily: 'Noto Sans Khmer')), // Add to Cart
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentCardScreen(amount: product.price),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('ទិញឥឡូវនេះ', style: TextStyle(fontSize: 18, fontFamily: 'Noto Sans Khmer')), // Buy Now
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}