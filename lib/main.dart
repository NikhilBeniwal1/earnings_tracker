import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'providers/earnings_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EarningsProvider()),
      ],
      child: MaterialApp(
        title: 'Earnings Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}


/*
Big Tech:

Apple: AAPL
Microsoft: MSFT
Alphabet (Google): GOOGL
Amazon: AMZN
Meta (Facebook): META
Tesla: TSLA
Nvidia: NVDA
Advanced Micro Devices (AMD): AMD
Other Notable Tech Companies:

Intel: INTC
Oracle: ORCL
Cisco Systems: CSCO
Adobe: ADBE
Salesforce: CRM
Netflix: NFLX
PayPal: PYPL
Twitter: TWTR*/
