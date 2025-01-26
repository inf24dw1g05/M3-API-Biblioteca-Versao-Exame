import 'package:flutter/material.dart';

class BookingProvider with ChangeNotifier {
  String? _fromCity;
  String? _toCity;
  DateTime? _departureDate;
  DateTime? _returnDate;
  int _passengerCount = 1;
  
  // Getters
  String? get fromCity => _fromCity;
  String? get toCity => _toCity;
  DateTime? get departureDate => _departureDate;
  DateTime? get returnDate => _returnDate;
  int get passengerCount => _passengerCount;
  
  void setFromCity(String city) {
    _fromCity = city;
    notifyListeners();
  }
  
  void setToCity(String city) {
    _toCity = city;
    notifyListeners();
  }
  
  void setDepartureDate(DateTime date) {
    _departureDate = date;
    notifyListeners();
  }
  
  void setReturnDate(DateTime? date) {
    _returnDate = date;
    notifyListeners();
  }
  
  void setPassengerCount(int count) {
    _passengerCount = count;
    notifyListeners();
  }
  
  void clearBooking() {
    _fromCity = null;
    _toCity = null;
    _departureDate = null;
    _returnDate = null;
    _passengerCount = 1;
    notifyListeners();
  }
}