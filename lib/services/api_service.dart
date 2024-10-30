import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/earnings_data.dart';
import '../utils/constants.dart';
const String apiKey = 'YOUR_API_KEY'; // Replace with your actual API key

class ApiService {
  static Future<List<EarningsData>> fetchEarnings(String ticker) async {
    final url = Uri.parse(
      'https://api.api-ninjas.com/v1/earningscalendar?ticker=$ticker',
    );

    final response = await http.get(url, headers: {'X-Api-Key': apiKey});

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      print(data);
      return data.map((item) => EarningsData.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch earnings data');
    }
  }

  static Future<String> fetchEarningsTranscript(
      String ticker, String year, int quarter) async {
    final url = Uri.parse(
        'https://api.api-ninjas.com/v1/earningstranscript?ticker=$ticker&year=$year&quarter=$quarter');

    final response = await http.get(url, headers: {'X-Api-Key': apiKey});

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['transcript'] ?? 'Transcript not available';
    } else {
      throw Exception('Failed to fetch transcript');
    }
  }
}
