// lib/screens/filter_screen.dart

import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  RangeValues _priceRange = RangeValues(0, 1000);
  bool _directFlights = false;
  List<String> _selectedAirlines = [];
  String _selectedCabinClass = 'Economy';
  int _selectedStops = 0;
  TimeOfDay? _departureTime;
  TimeOfDay? _arrivalTime;

  final List<String> _airlines = [
    'Air France',
    'British Airways',
    'Lufthansa',
    'KLM',
    'Emirates',
    'Qatar Airways',
  ];

  final List<String> _cabinClasses = [
    'Economy',
    'Premium Economy',
    'Business',
    'First Class',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter Flights'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _resetFilters,
            child: Text('Reset'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Price Range
            _buildSection(
              title: 'Price Range',
              child: Column(
                children: [
                  RangeSlider(
                    values: _priceRange,
                    min: 0,
                    max: 1000,
                    divisions: 100,
                    labels: RangeLabels(
                      '€${_priceRange.start.round()}',
                      '€${_priceRange.end.round()}',
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        _priceRange = values;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('€${_priceRange.start.round()}'),
                        Text('€${_priceRange.end.round()}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Direct Flights Toggle
            _buildSection(
              title: 'Flight Type',
              child: SwitchListTile(
                title: Text('Direct Flights Only'),
                value: _directFlights,
                onChanged: (bool value) {
                  setState(() {
                    _directFlights = value;
                  });
                },
              ),
            ),

            // Stops
            _buildSection(
              title: 'Number of Stops',
              child: Column(
                children: [
                  _buildStopsOption(0, 'Non-stop'),
                  _buildStopsOption(1, '1 Stop'),
                  _buildStopsOption(2, '2+ Stops'),
                ],
              ),
            ),

            // Airlines
            _buildSection(
              title: 'Airlines',
              child: Column(
                children: _airlines.map((airline) {
                  return CheckboxListTile(
                    title: Text(airline),
                    value: _selectedAirlines.contains(airline),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          _selectedAirlines.add(airline);
                        } else {
                          _selectedAirlines.remove(airline);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ),

            // Cabin Class
            _buildSection(
              title: 'Cabin Class',
              child: Column(
                children: _cabinClasses.map((cabinClass) {
                  return RadioListTile<String>(
                    title: Text(cabinClass),
                    value: cabinClass,
                    groupValue: _selectedCabinClass,
                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() {
                          _selectedCabinClass = value;
                        });
                      }
                    },
                  );
                }).toList(),
              ),
            ),

            // Time Range
            _buildSection(
              title: 'Time Range',
              child: Column(
                children: [
                  ListTile(
                    title: Text('Departure Time'),
                    trailing: Text(_departureTime?.format(context) ?? 'Any Time'),
                    onTap: () => _selectTime(context, true),
                  ),
                  ListTile(
                    title: Text('Arrival Time'),
                    trailing: Text(_arrivalTime?.format(context) ?? 'Any Time'),
                    onTap: () => _selectTime(context, false),
                  ),
                ],
              ),
            ),

            SizedBox(height: 100), // Space for bottom button
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: _applyFilters,
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Apply Filters',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        child,
        Divider(),
      ],
    );
  }

  Widget _buildStopsOption(int stops, String label) {
    return RadioListTile<int>(
      title: Text(label),
      value: stops,
      groupValue: _selectedStops,
      onChanged: (int? value) {
        if (value != null) {
          setState(() {
            _selectedStops = value;
          });
        }
      },
    );
  }

  Future<void> _selectTime(BuildContext context, bool isDeparture) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isDeparture) {
          _departureTime = picked;
        } else {
          _arrivalTime = picked;
        }
      });
    }
  }

  void _resetFilters() {
    setState(() {
      _priceRange = RangeValues(0, 1000);
      _directFlights = false;
      _selectedAirlines = [];
      _selectedCabinClass = 'Economy';
      _selectedStops = 0;
      _departureTime = null;
      _arrivalTime = null;
    });
  }

  void _applyFilters() {
    // Aqui você pode implementar a lógica para aplicar os filtros
    // e atualizar a lista de voos
    Navigator.pop(context);
  }
}