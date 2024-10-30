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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(height: 20),
              Divider(),
              Text(
                "Popular Company Tickers:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text("Big Tech:"),
              Text("Apple: AAPL"),
              Text("Microsoft: MSFT"),
              Text("Alphabet (Google): GOOGL"),
              Text("Amazon: AMZN"),
              Text("Meta (Facebook): META"),
              Text("Tesla: TSLA"),
              Text("Nvidia: NVDA"),
              Text("AMD: AMD"),
              SizedBox(height: 8),
              Text("Other Notable Tech Companies:"),
              Text("Intel: INTC"),
              Text("Oracle: ORCL"),
              Text("Cisco Systems: CSCO"),
              Text("Adobe: ADBE"),
              Text("Salesforce: CRM"),
              Text("Netflix: NFLX"),
              Text("PayPal: PYPL"),
              Text("Twitter: TWTR"),
            ],
          ),
        ),
      ),
    );
  }
}
