import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'payment_screen.dart';
import 'search_results_screen.dart';
import 'hotel_screen.dart';
import 'profile_screen.dart';
import 'passenger_details_screen.dart';
import 'payment_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  DateTime? _departureDate;
  DateTime? _returnDate;
  int _passengers = 1;
  int _selectedIndex = 0;
  int _hotelGuests = 1;

  // Lista de destinos populares
  final List<Map<String, String>> destinations = [
    {
      'city': 'Paris',
      'country': 'France',
      'price': '€199',
      'image': 'https://images.pexels.com/photos/532826/pexels-photo-532826.jpeg'
    },
    {
      'city': 'Santorini',
      'country': 'Greece',
      'price': '€299',
      'image': 'https://images.pexels.com/photos/1010657/pexels-photo-1010657.jpeg'
    },
    {
      'city': 'Venice',
      'country': 'Italy',
      'price': '€249',
      'image': 'https://images.pexels.com/photos/1796736/pexels-photo-1796736.jpeg'
    },
    {
      'city': 'Barcelona',
      'country': 'Spain',
      'price': '€179',
      'image': 'https://images.pexels.com/photos/819764/pexels-photo-819764.jpeg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A1034),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AppBar com logo e botão de perfil
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'TRIPSEEK',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.person_outline, color: Colors.white, size: 28),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProfileScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),

              // Botões de navegação
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    _buildNavButton('Flights', 0),
                    SizedBox(width: 8),
                    _buildNavButton('Hotels', 1),
                    SizedBox(width: 8),
                    _buildNavButton('Flight + Hotel', 2),
                  ],
                ),
              ),

              SizedBox(height: 32),

              // Conteúdo baseado na seleção
              if (_selectedIndex == 0)
                _buildFlightSearch()
              else if (_selectedIndex == 1)
                _buildHotelSearch()
              else
                _buildPackageSearch(),

              SizedBox(height: 32),

              // Popular Destinations Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Popular Destinations',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: 16),

              // Popular Destinations Grid
              _buildPopularDestinations(),

              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(String text, int index) {
    bool isSelected = _selectedIndex == index;
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.blue : Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(
              color: isSelected ? Colors.blue : Colors.white.withOpacity(0.3),
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildFlightSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Search. Book. Travel.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildSearchField('From where?', 'Ex: Paris', Icons.flight_takeoff),
                Divider(height: 1),
                _buildSearchField('To where?', 'Ex: London', Icons.flight_land),
                Divider(height: 1),
                Row(
                  children: [
                    Expanded(
                      child: _buildDateField('Departure', _departureDate, isDeparture: true),
                    ),
                    Container(
                      width: 1,
                      height: 56,
                      color: Colors.grey[300],
                    ),
                    Expanded(
                      child: _buildDateField('Return', _returnDate, isDeparture: false),
                    ),
                  ],
                ),
                Divider(height: 1),
                _buildPassengersField(),
              ],
            ),
          ),
          SizedBox(height: 16),
          _buildSearchButton('Search Flights'),
        ],
      ),
    );
  }

  Widget _buildHotelSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Find your perfect stay',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 24),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildSearchField(
                  'Where do you want to stay?',
                  'Ex: Paris',
                  Icons.location_on,
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildDateField('Check-in', _departureDate, isDeparture: true),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildDateField('Check-out', _returnDate, isDeparture: false),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                _buildGuestsField(),
              ],
            ),
          ),
          SizedBox(height: 16),
          _buildSearchButton('Search Hotels'),
        ],
      ),
    );
  }

  Widget _buildPackageSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Find complete packages',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildSearchField('From where?', 'Ex: Paris', Icons.flight_takeoff),
                Divider(height: 1),
                _buildSearchField('To where?', 'Ex: London', Icons.flight_land),
                Divider(height: 1),
                Row(
                  children: [
                    Expanded(
                      child: _buildDateField('Check-in', _departureDate, isDeparture: true),
                    ),
                    Container(
                      width: 1,
                      height: 56,
                      color: Colors.grey[300],
                    ),
                    Expanded(
                      child: _buildDateField('Check-out', _returnDate, isDeparture: false),
                    ),
                  ],
                ),
                Divider(height: 1),
                _buildPassengersField(),
              ],
            ),
          ),
          SizedBox(height: 16),
          _buildSearchButton('Search Packages'),
        ],
      ),
    );
  }

  Widget _buildSearchField(String label, String hint, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[600]),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: hint,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(String label, DateTime? date, {required bool isDeparture}) {
    return GestureDetector(
      onTap: () => _selectDate(context, isDeparture),
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

  Widget _buildPassengersField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(Icons.person, color: Colors.grey[600]),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Travelers',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
              Text(
                '$_passengers ${_passengers == 1 ? 'Traveler' : 'Travelers'}',
                style: TextStyle(color: Colors.grey[800]),
              ),
            ],
          ),
          Spacer(),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: _passengers > 1 ? () => setState(() => _passengers--) : null,
                color: Colors.grey[600],
              ),
              Text('$_passengers'),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: _passengers < 9 ? () => setState(() => _passengers++) : null,
                color: Colors.grey[600],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGuestsField() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Guests'),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: _hotelGuests > 1
                    ? () => setState(() => _hotelGuests--)
                    : null,
              ),
              Text('$_hotelGuests'),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: _hotelGuests < 10
                    ? () => setState(() => _hotelGuests++)
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchButton(String text) {
    return ElevatedButton(
      onPressed: () {
        if (_selectedIndex == 0 || _selectedIndex == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchResultsScreen()),
          );
        } else if (_selectedIndex == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HotelScreen()),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        minimumSize: Size(double.infinity, 50),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isDeparture) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isDeparture ? DateTime.now() : (_departureDate ?? DateTime.now()),
      firstDate: isDeparture ? DateTime.now() : (_departureDate ?? DateTime.now()),
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
          _departureDate = picked;
          if (_returnDate != null && _returnDate!.isBefore(_departureDate!)) {
            _returnDate = null;
          }
        } else {
          _returnDate = picked;
        }
      });
    }
  }

  Widget _buildPopularDestinations() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      padding: EdgeInsets.symmetric(horizontal: 16),
      itemCount: destinations.length,
      itemBuilder: (context, index) {
        final destination = destinations[index];
        return _buildDestinationCard(
          destination['city']!,
          destination['country']!,
          destination['image']!,
          destination['price']!,
        );
      },
    );
  }

 Widget _buildDestinationCard(String city, String country, String imageUrl, String price) {
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Icon(Icons.error_outline, size: 40, color: Colors.red),
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    city,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    country,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'From $price',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchResultsScreen(),
                    ),
                  ).then((_) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HotelScreen(),
                      ),
                    ).then((_) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PassengerDetailsScreen(),
                        ),
                      ).then((_) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentScreen(),
                          ),
                        );
                      });
                    });
                  });
                },
                splashColor: Colors.white.withOpacity(0.1),
                highlightColor: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }
}