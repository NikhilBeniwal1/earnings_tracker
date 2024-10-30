import 'package:flutter/material.dart';
import '../models/earnings_data.dart';
import '../services/api_service.dart';


class EarningsProvider with ChangeNotifier {
  List<EarningsData> _earnings = [];
  String _transcript = '';


  List<EarningsData> get earnings => _earnings;
  String get transcript => _transcript;

  Future<void> fetchEarnings(String ticker) async {
    _earnings = await ApiService.fetchEarnings(ticker);
    notifyListeners();
  }

  Future<String> fetchEarningsTranscript(String ticker, String date) async {
    final year = date.substring(0, 4);
    final quarter = (int.parse(date.substring(5, 7)) - 1) ~/ 3 + 1;
    _transcript = await ApiService.fetchEarningsTranscript(ticker, year, quarter);
    notifyListeners();
    return _transcript;
  }
}
