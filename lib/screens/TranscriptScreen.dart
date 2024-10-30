import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/earnings_provider.dart';

class TranscriptScreen extends StatelessWidget {
  final String date;
  final String ticker;

  TranscriptScreen({required this.date, required this.ticker});

  @override
  Widget build(BuildContext context) {
    final earningsProvider = Provider.of<EarningsProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Transcript for $ticker"),
      ),
      body: FutureBuilder(
        future: earningsProvider.fetchEarningsTranscript(ticker, date),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Failed to load transcript"));
          } else if (!snapshot.hasData || (snapshot.data as String).isEmpty) {
            return Center(child: Text("Transcript not available"));
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Text(
                  snapshot.data as String,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
