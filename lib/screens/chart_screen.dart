import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/earnings_provider.dart';

class ChartScreen extends StatelessWidget {
  final String ticker;

  ChartScreen({required this.ticker});

  @override
  Widget build(BuildContext context) {
    final earningsData = Provider.of<EarningsProvider>(context).earnings;

    // Prepare data points for the chart
    List<FlSpot> actualEpsData = [];
    List<FlSpot> estimatedEpsData = [];
    List<String> dateLabels = [];

    for (int i = 0; i < earningsData.length; i++) {
      final data = earningsData[i];
      dateLabels.add(data.pricedate); // Use pricedate property
      actualEpsData.add(FlSpot(i.toDouble(), data.actualEps)); // Access actualEps property
      estimatedEpsData.add(FlSpot(i.toDouble(), data.estimatedEps)); // Access estimatedEps property
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Earnings Chart for $ticker"),
      ),
      body: earningsData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Estimated vs. Actual EPS",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(
                    leftTitles: SideTitles(showTitles: true),
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTitles: (value) {
                        int index = value.toInt();
                        if (index >= 0 && index < dateLabels.length) {
                          return dateLabels[index];
                        }
                        return '';
                      },
                    ),
                  ),
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: actualEpsData,
                      isCurved: true,
                      colors: [Colors.blue], // Updated color parameter
                      barWidth: 2,
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(show: false),
                    ),
                    LineChartBarData(
                      spots: estimatedEpsData,
                      isCurved: true,
                      colors: [Colors.orange], // Updated color parameter
                      barWidth: 2,
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
