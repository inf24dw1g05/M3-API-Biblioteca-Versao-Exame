// lib/widgets/payment_method_card.dart

import 'package:flutter/material.dart';

class PaymentMethodCard extends StatelessWidget {
  final String methodId;
  final String title;
  final String description;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onSelect;
  final String? imageUrl;

  const PaymentMethodCard({
    Key? key,
    required this.methodId,
    required this.title,
    required this.description,
    required this.icon,
    required this.isSelected,
    required this.onSelect,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey[300]!,
            width: 2,
          ),
          color: isSelected ? Colors.blue.withOpacity(0.05) : Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              // Radio button
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? Colors.blue : Colors.grey[400]!,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: isSelected
                      ? Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                        )
                      : null,
                ),
              ),
              SizedBox(width: 16),

              // Icon or Image
              if (imageUrl != null)
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(imageUrl!),
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              else
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: isSelected ? Colors.blue : Colors.grey[600],
                    size: 24,
                  ),
                ),
              SizedBox(width: 16),

              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? Colors.blue : Colors.black,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Exemplo de uso:
class PaymentMethodsSection extends StatelessWidget {
  final String selectedMethod;
  final Function(String) onMethodSelected;

  const PaymentMethodsSection({
    Key? key,
    required this.selectedMethod,
    required this.onMethodSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PaymentMethodCard(
          methodId: 'credit_card',
          title: 'Credit Card',
          description: 'Pay with Visa, Mastercard, or American Express',
          icon: Icons.credit_card,
          isSelected: selectedMethod == 'credit_card',
          onSelect: () => onMethodSelected('credit_card'),
        ),
        PaymentMethodCard(
          methodId: 'paypal',
          title: 'PayPal',
          description: 'Fast and secure payment with PayPal',
          icon: Icons.paypal,
          isSelected: selectedMethod == 'paypal',
          onSelect: () => onMethodSelected('paypal'),
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/PayPal.svg/1200px-PayPal.svg.png',
        ),
        PaymentMethodCard(
          methodId: 'apple_pay',
          title: 'Apple Pay',
          description: 'Quick payment with Apple Pay',
          icon: Icons.apple,
          isSelected: selectedMethod == 'apple_pay',
          onSelect: () => onMethodSelected('apple_pay'),
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b0/Apple_Pay_logo.svg/1200px-Apple_Pay_logo.svg.png',
        ),
        PaymentMethodCard(
          methodId: 'google_pay',
          title: 'Google Pay',
          description: 'Easy payment with Google Pay',
          icon: Icons.g_mobiledata,
          isSelected: selectedMethod == 'google_pay',
          onSelect: () => onMethodSelected('google_pay'),
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/Google_Pay_Logo_%282020%29.svg/1200px-Google_Pay_Logo_%282020%29.svg.png',
        ),
      ],
    );
  }
}