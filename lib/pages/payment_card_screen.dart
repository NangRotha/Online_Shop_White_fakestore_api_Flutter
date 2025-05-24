import 'package:flutter/material.dart';

class PaymentCardScreen extends StatefulWidget {
  final double amount; // To display the amount to be paid

  const PaymentCardScreen({super.key, required this.amount});

  @override
  State<PaymentCardScreen> createState() => _PaymentCardScreenState();
}

class _PaymentCardScreenState extends State<PaymentCardScreen> {
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();

  Future<void> _processPayment(BuildContext context) async {
    // Basic validation
    if (_cardNumberController.text.isEmpty ||
        _expiryDateController.text.isEmpty ||
        _cvvController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('សូមបំពេញព័ត៌មានកាតទាំងអស់។', style: TextStyle(fontFamily: 'Noto Sans Khmer'))), // Please fill all card details.
      );
      return;
    }

    // Simulate payment processing
    showDialog(
      context: context,
      barrierDismissible: false, // User must tap OK to dismiss
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ការទូទាត់បានជោគជ័យ', style: TextStyle(fontFamily: 'Noto Sans Khmer')), // Payment Successful
          content: Text(
              'ការទូទាត់របស់អ្នកចំនួន \$${widget.amount.toStringAsFixed(2)} បានជោគជ័យ។', // Your payment of $... was successful.
              style: const TextStyle(fontFamily: 'Noto Sans Khmer')),
          actions: <Widget>[
            TextButton(
              child: const Text('យល់ព្រម', style: TextStyle(fontFamily: 'Noto Sans Khmer')), // OK
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Go back to the product detail page
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('ការបញ្ជាទិញបានដាក់ដោយជោគជ័យ!', style: TextStyle(fontFamily: 'Noto Sans Khmer'))), // Order placed successfully!
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ព័ត៌មានលម្អិតអំពីការទូទាត់', style: TextStyle(fontFamily: 'Noto Sans Khmer')), // Payment Details
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch children to full width
          children: <Widget>[
            Text(
              'ចំនួនទឹកប្រាក់ដែលត្រូវបង់: \$${widget.amount.toStringAsFixed(2)}', // Amount to pay: $...
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[800],
                    fontFamily: 'Noto Sans Khmer',
                  ),
            ),
            const SizedBox(height: 30),
            // Card Number
            TextFormField(
              controller: _cardNumberController,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontFamily: 'Noto Sans Khmer'),
              decoration: InputDecoration(
                labelText: 'លេខកាត', // Card Number
                labelStyle: const TextStyle(fontFamily: 'Noto Sans Khmer'),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                prefixIcon: const Icon(Icons.credit_card),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    controller: _expiryDateController,
                    keyboardType: TextInputType.datetime,
                    style: const TextStyle(fontFamily: 'Noto Sans Khmer'),
                    decoration: InputDecoration(
                      labelText: 'ថ្ងៃផុតកំណត់ (ខខ/ឆឆ)', // Expiry Date (MM/YY)
                      labelStyle: const TextStyle(fontFamily: 'Noto Sans Khmer'),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      prefixIcon: const Icon(Icons.calendar_today),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: _cvvController,
                    keyboardType: TextInputType.number,
                    obscureText: true, // Hide CVV
                    style: const TextStyle(fontFamily: 'Noto Sans Khmer'),
                    decoration: InputDecoration(
                      labelText: 'លេខ CVV', // CVV
                      labelStyle: const TextStyle(fontFamily: 'Noto Sans Khmer'),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      prefixIcon: const Icon(Icons.lock),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _processPayment(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  textStyle: const TextStyle(fontFamily: 'Noto Sans Khmer', fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: const Text('បង់ប្រាក់ឥឡូវនេះ'), // Pay Now
              ),
            ),
          ],
        ),
      ),
    );
  }
}