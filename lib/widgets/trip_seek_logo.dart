// lib/widgets/trip_seek_logo.dart
import 'package:flutter/material.dart';

class TripSeekLogo extends StatelessWidget {
  final double size;
  final Color? textColor;
  final bool showShadow;

  const TripSeekLogo({
    Key? key,
    this.size = 150,
    this.textColor,
    this.showShadow = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: Colors.white.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 15,
                ),
              ]
            : null,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Colors.blue[300]!,
                  Colors.blue[600]!,
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.flight,
                size: size * 0.3,
                color: Colors.white,
              ),
              SizedBox(height: size * 0.05),
              Text(
                'Trip Seek',
                style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontSize: size * 0.16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}