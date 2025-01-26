// payment_methods_screen.dart
import 'package:flutter/material.dart';

class PaymentMethodsScreen extends StatefulWidget {
  @override
  _PaymentMethodsScreenState createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  final List<Map<String, dynamic>> paymentMethods = [
    {
      'type': 'Credit Card',
      'brand': 'Visa',
      'number': '**** **** **** 4567',
      'expiry': '12/25',
      'isDefault': true,
    },
    {
      'type': 'Credit Card',
      'brand': 'Mastercard',
      'number': '**** **** **** 8901',
      'expiry': '09/24',
      'isDefault': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Methods'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ...paymentMethods.map((method) => _buildPaymentCard(method)),
          SizedBox(height: 16),
          _buildAddPaymentButton(),
        ],
      ),
    );
  }

  Widget _buildPaymentCard(Map<String, dynamic> method) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Icon(
          method['brand'] == 'Visa' ? Icons.credit_card : Icons.credit_score,
          size: 40,
          color: Colors.blue,
        ),
        title: Row(
          children: [
            Text(
              method['brand'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (method['isDefault'])
              Container(
                margin: EdgeInsets.only(left: 8),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Default',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(method['number']),
            Text('Expires: ${method['expiry']}'),
          ],
        ),
        trailing: PopupMenuButton(
          icon: Icon(Icons.more_vert),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text('Set as Default'),
              value: 'default',
            ),
            PopupMenuItem(
              child: Text('Edit'),
              value: 'edit',
            ),
            PopupMenuItem(
              child: Text('Delete'),
              value: 'delete',
            ),
          ],
          onSelected: (value) {
            switch (value) {
              case 'default':
                _setAsDefault(method);
                break;
              case 'edit':
                _editPaymentMethod(method);
                break;
              case 'delete':
                _deletePaymentMethod(method);
                break;
            }
          },
        ),
      ),
    );
  }

  Widget _buildAddPaymentButton() {
    return ElevatedButton(
      onPressed: _addNewPaymentMethod,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add),
          SizedBox(width: 8),
          Text('Add New Payment Method'),
        ],
      ),
    );
  }

  void _setAsDefault(Map<String, dynamic> method) {
    setState(() {
      for (var m in paymentMethods) {
        m['isDefault'] = m == method;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment method set as default'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _editPaymentMethod(Map<String, dynamic> method) {
    // Implementar edição do método de pagamento
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Payment Method'),
        content: Text('Edit functionality coming soon'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _deletePaymentMethod(Map<String, dynamic> method) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Payment Method'),
        content: Text('Are you sure you want to delete this payment method?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                paymentMethods.remove(method);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Payment method deleted'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: Text('Delete'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  void _addNewPaymentMethod() {
    // Implementar adição de novo método de pagamento
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Payment Method'),
        content: Text('Add payment method functionality coming soon'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}