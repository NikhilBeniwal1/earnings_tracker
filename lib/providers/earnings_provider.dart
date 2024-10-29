import 'package:flutter/material.dart';
import '../models/earnings_data.dart';
import '../services/api_service.dart';

class EarningsProvider with ChangeNotifier {
  List<EarningsData> _earnings = [];

  List<EarningsData> get earnings => _earnings;

  Future<void> fetchEarnings(String ticker) async {
    _earnings = await ApiService.fetchEarnings(ticker);
    notifyListeners();

  }
}
