import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mysmallshop/features/cart/cart_cubit.dart';
import 'package:mysmallshop/features/profile/widgets/order_sucess_screen.dart';
import 'package:mysmallshop/widgets/custom_elevated_button.dart';


class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String _selectedMethod = 'Cash on Delivery';
  final _formKey = GlobalKey<FormState>();

  final _cardNumberController = TextEditingController();
  final _cardNameController = TextEditingController();
  final _cardExpiryController = TextEditingController();
  final _cardCvvController = TextEditingController();

  void _confirmPayment() {
    if (_selectedMethod == 'Card Payment' &&
        !_formKey.currentState!.validate()) {
      return;
    }

    context.read<CartCubit>().clearCart();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment successful via $_selectedMethod. Cart cleared.'),
      ),
    );

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OrderSuccessScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: theme.primaryColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'Select Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Gap(16),

            RadioListTile<String>(
              value: 'Cash on Delivery',
              groupValue: _selectedMethod,
              onChanged: (value) => setState(() => _selectedMethod = value!),
              title: const Text('Cash on Delivery'),
              secondary: const Icon(Icons.attach_money, color: Colors.teal),
            ),
            const Divider(),

            RadioListTile<String>(
              value: 'Card Payment',
              groupValue: _selectedMethod,
              onChanged: (value) => setState(() => _selectedMethod = value!),
              title: const Text('Pay by Bank Card'),
              secondary: const Icon(Icons.credit_card, color: Colors.teal),
            ),

            if (_selectedMethod == 'Card Payment') ...[
              const Gap(16),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _cardNameController,
                      decoration: const InputDecoration(
                        labelText: 'Cardholder Name',
                        border: OutlineInputBorder(),
                      ),
                      validator:
                          (value) =>
                              value!.isEmpty ? 'Enter cardholder name' : null,
                    ),
                    const Gap(12),
                    TextFormField(
                      controller: _cardNumberController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Card Number',
                        border: OutlineInputBorder(),
                      ),
                      validator:
                          (value) =>
                              value!.length < 16
                                  ? 'Enter valid card number'
                                  : null,
                    ),
                    const Gap(12),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _cardExpiryController,
                            keyboardType: TextInputType.datetime,
                            decoration: const InputDecoration(
                              labelText: 'Expiry (MM/YY)',
                              border: OutlineInputBorder(),
                            ),
                            validator:
                                (value) =>
                                    value!.isEmpty ? 'Enter expiry date' : null,
                          ),
                        ),
                        const Gap(12),
                        Expanded(
                          child: TextFormField(
                            controller: _cardCvvController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'CVV',
                              border: OutlineInputBorder(),
                            ),
                            validator:
                                (value) =>
                                    value!.length < 3
                                        ? 'Enter valid CVV'
                                        : null,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],

            const Gap(32),
            CustomElevatedButton(
              text: "Confirm Payment",
              onPressed: _confirmPayment,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
