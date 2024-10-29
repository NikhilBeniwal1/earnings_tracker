import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/earnings_provider.dart';
import 'chart_screen.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _tickerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Earnings Tracker"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tickerController,
              decoration: InputDecoration(labelText: "Enter Company Ticker"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final ticker = _tickerController.text;
                if (ticker.isNotEmpty) {
                  // Fetch earnings and navigate to chart
                  Provider.of<EarningsProvider>(context, listen: false)
                      .fetchEarnings(ticker)
                      .then((_) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChartScreen(ticker: ticker),
                      ),
                    );
                  });
                }
              },
              child: Text("Show Earnings Chart"),
            ),
          ],
        ),
      ),
    );
  }
}
