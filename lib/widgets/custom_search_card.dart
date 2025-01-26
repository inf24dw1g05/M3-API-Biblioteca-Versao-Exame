// lib/widgets/custom_search_card.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomSearchCard extends StatefulWidget {
  final Function(String, String, DateTime) onSearch;

  const CustomSearchCard({
    Key? key,
    required this.onSearch,
  }) : super(key: key);

  @override
  _CustomSearchCardState createState() => _CustomSearchCardState();
}

class _CustomSearchCardState extends State<CustomSearchCard> {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  bool _isRoundTrip = false;
  DateTime? _returnDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Trip Type Toggle
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _buildToggleButton('One Way', !_isRoundTrip, () {
                  setState(() {
                    _isRoundTrip = false;
                    _returnDate = null;
                  });
                }),
                SizedBox(width: 12),
                _buildToggleButton('Round Trip', _isRoundTrip, () {
                  setState(() {
                    _isRoundTrip = true;
                  });
                }),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                // From Field
                _buildLocationField(
                  controller: _fromController,
                  label: 'From',
                  icon: Icons.flight_takeoff,
                  hint: 'Departure City',
                ),
                SizedBox(height: 16),

                // To Field
                _buildLocationField(
                  controller: _toController,
                  label: 'To',
                  icon: Icons.flight_land,
                  hint: 'Arrival City',
                ),
                SizedBox(height: 16),

                // Date Selection
                Row(
                  children: [
                    Expanded(
                      child: _buildDateField(
                        label: 'Departure',
                        date: _selectedDate,
                        onTap: () => _selectDate(context, true),
                      ),
                    ),
                    if (_isRoundTrip) ...[
                      SizedBox(width: 16),
                      Expanded(
                        child: _buildDateField(
                          label: 'Return',
                          date: _returnDate,
                          onTap: () => _selectDate(context, false),
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 20),

                // Search Button
                ElevatedButton(
                  onPressed: () {
                    if (_validateFields()) {
                      widget.onSearch(
                        _fromController.text,
                        _toController.text,
                        _selectedDate,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Search Flights',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[600],
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.blue),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[50],
        ),
      ),
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.blue),
                SizedBox(width: 8),
                Text(
                  date != null
                      ? DateFormat('dd MMM yyyy').format(date)
                      : 'Select Date',
                  style: TextStyle(
                    fontSize: 16,
                    color: date != null ? Colors.black : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isDeparture) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isDeparture ? _selectedDate : (_returnDate ?? _selectedDate),
      firstDate: isDeparture ? DateTime.now() : _selectedDate,
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isDeparture) {
          _selectedDate = picked;
          if (_returnDate != null && _returnDate!.isBefore(_selectedDate)) {
            _returnDate = null;
          }
        } else {
          _returnDate = picked;
        }
      });
    }
  }

  bool _validateFields() {
    if (_fromController.text.isEmpty) {
      _showError('Please enter departure city');
      return false;
    }
    if (_toController.text.isEmpty) {
      _showError('Please enter arrival city');
      return false;
    }
    if (_fromController.text == _toController.text) {
      _showError('Departure and arrival cities cannot be the same');
      return false;
    }
    if (_isRoundTrip && _returnDate == null) {
      _showError('Please select return date');
      return false;
    }
    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}