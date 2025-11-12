import 'package:flutter/material.dart';
import 'package:mysmallshop/features/home/screens/home_screen.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.teal, size: 80),
            const SizedBox(height: 16),
            const Text(
              "Order Placed Successfully!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("Thank you for your purchase."),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed:
                  () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => HomeScreen()),
                  ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              child: const Text("Back to Shop"),
            ),
          ],
        ),
      ),
    );
  }
}
