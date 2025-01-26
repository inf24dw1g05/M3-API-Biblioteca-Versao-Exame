import 'package:flutter/material.dart';

class PassengerCounter extends StatefulWidget {
  final Function(int) onChanged;

  PassengerCounter({required this.onChanged});

  @override
  _PassengerCounterState createState() => _PassengerCounterState();
}

class _PassengerCounterState extends State<PassengerCounter> {
  int _passengerCount = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Passengers'),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: _passengerCount > 1
                  ? () {
                      setState(() {
                        _passengerCount--;
                        widget.onChanged(_passengerCount);
                      });
                    }
                  : null,
            ),
            Text('$_passengerCount'),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: _passengerCount < 9
                  ? () {
                      setState(() {
                        _passengerCount++;
                        widget.onChanged(_passengerCount);
                      });
                    }
                  : null,
            ),
          ],
        ),
      ],
    );
  }
}