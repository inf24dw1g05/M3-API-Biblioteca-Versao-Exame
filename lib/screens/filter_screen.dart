import 'package:flutter/material.dart';
import '../widgets/price_range_slider.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _directFlights = false;
  String _selectedAirline = 'All Airlines';
  List<String> _airlines = ['All Airlines', 'Airline 1', 'Airline 2', 'Airline 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter Flights'),
        actions: [
          TextButton(
            child: Text('Reset', style: TextStyle(color: Colors.white)),
            onPressed: () {
              // Reset all filters
              setState(() {
                _directFlights = false;
                _selectedAirline = 'All Airlines';
              });
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          PriceRangeSlider(
  minPrice: 0,
  maxPrice: 1000,
  onChanged: (minPrice, maxPrice) {
    print('Price range: €$minPrice - €$maxPrice');
    // Handle price range change
  },
),
          Divider(),
          SwitchListTile(
            title: Text('Direct Flights Only'),
            value: _directFlights,
            onChanged: (bool value) {
              setState(() {
                _directFlights = value;
              });
            },
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Airlines'),
                SizedBox(height: 8),
                DropdownButton<String>(
                  isExpanded: true,
                  value: _selectedAirline,
                  items: _airlines.map((String airline) {
                    return DropdownMenuItem<String>(
                      value: airline,
                      child: Text(airline),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedAirline = newValue;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16),
        child: ElevatedButton(
          child: Text('Apply Filters'),
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }
}