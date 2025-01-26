import 'package:flutter/material.dart';
import '../screens/home_screen.dart';

class BookingConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Progress Indicator showing completion
            Container(
              padding: EdgeInsets.all(16),
              child: LinearProgressIndicator(
                value: 1.0,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24),
                child: Column(
                  children: [
                    // Success Icon
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_circle,
                        size: 80,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(height: 24),
                    
                    // Confirmation Message
                    Text(
                      'Booking Confirmed!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Your booking has been confirmed and your tickets have been sent to your email.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 32),
                    
                    // Booking Details Card
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _buildDetailRow(
                              'Booking Reference',
                              'ABC123XYZ',
                              icon: Icons.confirmation_number,
                            ),
                            Divider(height: 32),
                            _buildDetailRow(
                              'Flight',
                              'Paris → London',
                              icon: Icons.flight,
                            ),
                            SizedBox(height: 16),
                            _buildDetailRow(
                              'Hotel',
                              'Grand Hotel Paris',
                              icon: Icons.hotel,
                            ),
                            SizedBox(height: 16),
                            _buildDetailRow(
                              'Check-in',
                              '15 Jan 2025',
                              icon: Icons.calendar_today,
                            ),
                            SizedBox(height: 16),
                            _buildDetailRow(
                              'Check-out',
                              '20 Jan 2025',
                              icon: Icons.event_available,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                    
                    // Action Buttons
                    ElevatedButton.icon(
                      onPressed: () {
                        // Download tickets functionality
                      },
                      icon: Icon(Icons.download),
                      label: Text('Download Tickets'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (route) => false,
                        );
                      },
                      child: Text('Return to Home'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {required IconData icon}) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.blue),
        SizedBox(width: 12),
        Column(
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
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}