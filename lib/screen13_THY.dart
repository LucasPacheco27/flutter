import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class THYDetailScreen extends StatefulWidget {
  const THYDetailScreen({super.key});

  @override
  State<THYDetailScreen> createState() => _THYDetailScreenState();
}

class _THYDetailScreenState extends State<THYDetailScreen> {
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
      'http://api.marketstack.com/v1/eod?access_key=5f1efd8ca26b747445c24ffe3c51b296&symbols=THYAO.IS&limit=30',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final data = jsonData['data'];

        if (data != null && data.length >= 2) {
          final List<FlSpot> spots = [];
          final List<String> dateLabels = [];

          for (int i = 0; i < data.length; i++) {
            final close = (data[i]['close'] ?? 0).toDouble();
            spots.add(FlSpot(i.toDouble(), close));
            final parsedDate = DateTime.parse(data[i]['date']);
            dateLabels.add(DateFormat('MM/dd').format(parsedDate));
          }

          setState(() {
            priceSpots = spots.reversed.toList();
            dates = dateLabels.reversed.toList();
            currentPrice = data[0]['close'];
            priceChange = data[0]['close'] - data[1]['close'];
          });
        }
      }
    } catch (e) {
      print('Error fetching stock data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPositive = priceChange >= 0;
    final changePercent =
        currentPrice != 0 ? (priceChange / currentPrice) * 100 : 0;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BackButton(color: Colors.black),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.notifications_none),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.bookmark_border),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Stock Info Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.shade800,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "THYAO",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "Turkish Airlines",
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Image.asset('assets/images/thy_logo.png', width: 55),
              ],
            ),

            const SizedBox(height: 11),

            // Price & Change
            Text(
              "₺ ${currentPrice.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Text(
              "${isPositive ? '+' : ''}${priceChange.toStringAsFixed(2)} ₺ "
              "(${changePercent.toStringAsFixed(2)}%)",
              style: TextStyle(
                color: isPositive ? Colors.green : Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 50),

            // Chart
            priceSpots.isEmpty
                ? const SizedBox(
                  height: 220,
                  child: Center(child: CircularProgressIndicator()),
                )
                : SizedBox(
                  height: 220,
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        getDrawingHorizontalLine:
                            (value) => FlLine(
                              color: Colors.grey.shade300,
                              strokeWidth: 0.6,
                              dashArray: [5, 5],
                            ),
                      ),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 5,
                            reservedSize: 30,
                            getTitlesWidget: (value, _) {
                              final index = value.toInt();
                              if (index >= 0 && index < dates.length) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    dates[index],
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: priceSpots,
                          isCurved: true,
                          color: Colors.green,
                          dotData: FlDotData(show: true),
                          belowBarData: BarAreaData(
                            show: true,
                            color: Colors.green.withOpacity(0.2),
                          ),
                          barWidth: 2.4,
                        ),
                      ],
                    ),
                  ),
                ),

            const SizedBox(height: 24),

            // 📌 TrackVest Info Below Chart
            const Text(
              "This is the midpoint between buy and sell rates. Actual rate varies based on whether you buy or sell. Pricing data is provided by TrackVest.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 8.5, color: Colors.grey),
            ),

            const SizedBox(height: 24),

            // Investment Info & Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 4, bottom: 6),
                    child: Text(
                      "Investment",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E5FF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "536,25 ₺",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "Total Value",
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            // Eğer asset logosu varsa, kullanabilirsin
                            Image.asset(
                              'assets/images/thy_logo.png',
                              width: 20,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Holding",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "23,56 THYAO",
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text(
                                  "536,25 ₺",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_drop_up,
                                      size: 18,
                                      color: Colors.green,
                                    ),
                                    Text(
                                      "22,73 %",
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text("Buy"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text("Sell"),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            side: const BorderSide(color: Colors.black),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            const Divider(height: 20),

            // Bottom Navigation
          ],
        ),
      ),
    );
  }
}
