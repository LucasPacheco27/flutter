import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';

class AAPLDetailScreen extends StatefulWidget {
  const AAPLDetailScreen({super.key});

  @override
  State<AAPLDetailScreen> createState() => _AAPLDetailScreenState();
}

class _AAPLDetailScreenState extends State<AAPLDetailScreen> {
  double currentPrice = 0.0;
  double priceChange = 0.0;
  List<FlSpot> priceSpots = [];
  List<String> dates = [];

  @override
  void initState() {
    super.initState();
    fetchStockData();
  }

  Future<void> fetchStockData() async {
    final url = Uri.parse(
      'https://api.marketstack.com/v1/eod?access_key=5f1efd8ca26b747445c24ffe3c51b296&symbols=AAPL&limit=30',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;

      final reversedData = data.reversed.toList();

      final List<FlSpot> spots = [];
      final List<String> fetchedDates = [];

      for (int i = 0; i < reversedData.length; i++) {
        double close = (reversedData[i]['close'] as num).toDouble();
        String date = reversedData[i]['date'].substring(0, 10);
        spots.add(FlSpot(i.toDouble(), close));
        fetchedDates.add(date);
      }

      setState(() {
        priceSpots = spots;
        dates = fetchedDates;
        currentPrice = spots.last.y;
        if (spots.length > 1) {
          priceChange = spots.last.y - spots[spots.length - 2].y;
        } else {
          priceChange = 0.0;
        }
      });
    } else {
      debugPrint('Failed to load stock data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPositive = priceChange >= 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        toolbarHeight: 32,
        leading: BackButton(color: Colors.white),
        actions: [
          IconButton(icon: Icon(Icons.notifications_none), onPressed: () {}),
          IconButton(icon: Icon(Icons.bookmark_border), onPressed: () {}),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 190,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFD9CFFF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(Icons.apple, size: 30),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Total Value", style: TextStyle(fontSize: 14)),
                        Text(
                          '536,25 €',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text("+22,73%", style: TextStyle(color: Colors.green)),
                        Text("23,56 AAPL", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Buy"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text("Sell"),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        side: BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Chip(
                  label: Text("AAPL", style: TextStyle(color: Colors.white)),
                  backgroundColor: Colors.black,
                ),
                const SizedBox(width: 10),
                Text("Apple", style: TextStyle(fontSize: 16)),
                const Spacer(),
                Icon(Icons.apple, size: 32),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              '€ ${currentPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Text(
              '${isPositive ? '+' : ''}${priceChange.toStringAsFixed(2)} € '
              '(${((priceChange / currentPrice) * 100).toStringAsFixed(2)}%)',
              style: TextStyle(
                color: isPositive ? Colors.green : Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            priceSpots.isEmpty
                ? Expanded(child: Center(child: CircularProgressIndicator()))
                : SizedBox(
                  height: 200,
                  child: LineChart(
                    LineChartData(
                      borderData: FlBorderData(show: false),
                      gridData: FlGridData(
                        show: true,
                        drawHorizontalLine: true,
                        getDrawingHorizontalLine:
                            (value) => FlLine(
                              color: Colors.grey.shade300,
                              strokeWidth: 1,
                            ),
                        drawVerticalLine: false,
                      ),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 5,
                            getTitlesWidget: (value, meta) {
                              int index = value.toInt();
                              if (index >= 0 && index < dates.length) {
                                return Text(
                                  dates[index].substring(5),
                                  style: TextStyle(fontSize: 10),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      lineTouchData: LineTouchData(
                        enabled: true,
                        touchTooltipData: LineTouchTooltipData(
                          getTooltipItems: (touchedSpots) {
                            return touchedSpots.map((spot) {
                              return LineTooltipItem(
                                '${dates[spot.x.toInt()]}\n€ ${spot.y.toStringAsFixed(2)}',
                                const TextStyle(color: Colors.white),
                              );
                            }).toList();
                          },
                        ),
                        handleBuiltInTouches: true,
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: priceSpots,
                          isCurved: true,
                          color: Colors.green.shade700,
                          barWidth: 3,
                          isStrokeCapRound: true,
                          belowBarData: BarAreaData(
                            show: true,
                            color: Colors.green.withOpacity(0.2),
                          ),
                          dotData: FlDotData(
                            show: true,
                            getDotPainter:
                                (spot, percent, barData, index) =>
                                    FlDotCirclePainter(
                                      radius: 3,
                                      color: Colors.green,
                                      strokeColor: Colors.white,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            const SizedBox(height: 8),
            Text(
              'This is the midpoint between buy and sell rates. Actual rate varies based on whether you buy or sell. Pricing data is provided by TrackVest.',
              style: TextStyle(fontSize: 8, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
