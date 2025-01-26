import 'package:flutter/material.dart';
import '../widgets/hotel_card.dart';
import 'passenger_details_screen.dart';

class HotelScreen extends StatelessWidget {
  final List<Map<String, dynamic>> hotels = [
    {
      'name': 'Grand Hotel Paris',
      'location': 'Champs-Élysées',
      'price': 299.99,
      'rating': 4.8,
      'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945',
      'amenities': ['Free WiFi', 'Spa', 'Pool', 'Restaurant'],
    },
    {
      'name': 'Luxury Palace Hotel',
      'location': 'City Center',
      'price': 359.99,
      'rating': 4.9,
      'image': 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb',
      'amenities': ['Free WiFi', 'Gym', 'Pool', 'Bar'],
    },
    // Adicione mais hotéis aqui
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Hotel'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Progresso da reserva
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: 0.5, // 2/4 do processo
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  'Step 2/4',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Resumo do voo selecionado
          Card(
            margin: EdgeInsets.all(16),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selected Flight',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.flight, color: Colors.blue),
                      SizedBox(width: 8),
                      Text(
                        'Paris → London',
                        style: TextStyle(fontSize: 16),
                      ),
                      Spacer(),
                      Text(
                        '€299',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Lista de hotéis
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: hotels.length,
              itemBuilder: (context, index) {
                final hotel = hotels[index];
                return HotelCard(
                  hotelName: hotel['name'],
                  location: hotel['location'],
                  price: hotel['price'],
                  rating: hotel['rating'],
                  imageUrl: hotel['image'],
                  amenities: List<String>.from(hotel['amenities']),
                  onSelect: () {
                    // Atualizar provider com hotel selecionado
                    
                    // Navegar para detalhes dos passageiros
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PassengerDetailsScreen(),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}