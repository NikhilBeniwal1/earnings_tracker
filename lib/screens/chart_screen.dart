import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/earnings_provider.dart';
import 'TranscriptScreen.dart';

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
            Row(
              children: [
                Icon(Icons.circle, color: Colors.orange, size: 16),
                SizedBox(width: 8),
                Text(
                  "Estimated vs Actual EPS",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Icon(Icons.circle, color: Colors.blue, size: 16),
              ],
            ),

            SizedBox(height: 20),
            Expanded(
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: 1, // Show every label at 1 interval
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();
                          if (index >= 0 && index < dateLabels.length) {
                            // Only show selected labels to avoid crowding
                            return (index % 2 == 0) // Show every 2nd date
                                ? Transform.rotate(
                              angle: -0.5, // Rotate the text slightly
                              child: Text(
                                dateLabels[index],
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black,
                                ),
                              ),
                            )
                                : Container();
                          }
                          return Container();
                        },
                      ),
                    ),
                  ),
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: actualEpsData,
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 2,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) =>
                            FlDotCirclePainter(
                              radius: 4,
                              color: Colors.blue,
                              strokeColor: Colors.white,
                            ),
                      ),
                      belowBarData: BarAreaData(show: false),
                    ),
                    LineChartBarData(
                      spots: estimatedEpsData,
                      isCurved: true,
                      color: Colors.orange,
                      barWidth: 2,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) =>
                            FlDotCirclePainter(
                              radius: 4,
                              color: Colors.orange,
                              strokeColor: Colors.white,
                            ),
                      ),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                     // getTooltipColor: Colors.blueAccent,
                      getTooltipItems: (List<LineBarSpot> touchedSpots) {
                        return touchedSpots.map((spot) {
                          final dataIndex = spot.x.toInt();
                          final data = earningsData[dataIndex];
                          return LineTooltipItem(
                            '${data.pricedate}\nActual EPS: ${data.actualEps}\nEstimated EPS: ${data.estimatedEps}',
                            TextStyle(color: Colors.white),
                          );
                        }).toList();
                      },
                    ),
                    touchCallback: (FlTouchEvent event, LineTouchResponse? touchResponse) {
                      if (!event.isInterestedForInteractions || touchResponse == null || touchResponse.lineBarSpots == null) {
                        return;
                      }
                      final spot = touchResponse.lineBarSpots!.first;
                      final dataIndex = spot.x.toInt();
                      final data = earningsData[dataIndex];

                      // Navigate to a new screen with the transcript
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TranscriptScreen(
                            date: data.pricedate,
                            ticker: ticker,
                          ),
                        ),
                      );
                    },
                    handleBuiltInTouches: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
