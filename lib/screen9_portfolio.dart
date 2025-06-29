import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen10_profile.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

import 'screen12_aapl.dart';
import 'screen13_THY.dart';

const String TWELVEDATA_API_KEY = '27d93abda55e4e19a30af71578cdf523';

class Stock {
  final String symbol;
  final String name;
  final double price;
  final String iconUrl;

  Stock({
    required this.symbol,
    required this.name,
    required this.price,
    required this.iconUrl,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    String stockName;
    String stockIconUrl;

    switch (json['symbol']) {
      case "AAPL":
        stockName = "Apple Inc.";
        stockIconUrl =
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1qzDUfdVdRa2_RvXC5K1SeguSkxcMWmjnjw&s";
        break;
      case "THY":
        stockName = "Turkish Airlines";
        stockIconUrl =
            "https://imgs.search.brave.com/W6DmJj9HcwUFbsaRHlBpFZvFEu7IlvtsYCPRh1S0Rwg/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZXMuc2Vla2xvZ28u/Y29tL2xvZ28tcG5n/LzM2LzIvdHVya2lz/aC1haXJsaW5lcy1s/b2dvLXBuZ19zZWVr/bG9nby0zNjYwNzgu/cG5n";
        break;
      case "AMZN":
        stockName = "Amazon.com, Inc.";
        stockIconUrl =
            "https://imgs.search.brave.com/EMxvXUYdtKMLmkVuAwxBgwqJoovYRbd2inxUlXqp6Dk/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9jZG4t/aWNvbnMtcG5nLmZy/ZWVwaWsuY29tLzI1/Ni8xMTM3Ni8xMTM3/NjMwMi5wbmc_c2Vt/dD1haXNfaHlicmlk";
        break;
      default:
        stockName = json['symbol'];
        stockIconUrl = "";
    }

    return Stock(
      symbol: json['symbol'],
      name: stockName,
      price: double.tryParse(json['close'] ?? '0') ?? 0,
      iconUrl: stockIconUrl,
    );
  }
}

Future<List<Stock>> fetchStocks() async {
  final String apiUrl =
      'https://api.twelvedata.com/quote?symbol=AAPL,THY,AMZN&apikey=$TWELVEDATA_API_KEY';

  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    Map<String, dynamic> responseData = json.decode(response.body);

    if (responseData.containsKey('code') && responseData['code'] != null) {
      throw Exception('API Error: ${responseData['message']}');
    }

    List<Stock> stocks = [];

    responseData.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        stocks.add(Stock.fromJson(value));
      }
    });

    if (stocks.isEmpty) {
      throw Exception('No stock data received from API');
    }

    return stocks;
  } else {
    throw Exception('Failed to load shares from API: ${response.statusCode}');
  }
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({Key? key}) : super(key: key);

  @override
  State<PortfolioPage> createState() => _MainPageState();
}

class _MainPageState extends State<PortfolioPage> {
  late Future<List<Stock>> futureStocks;
  int _selectedIndex = 2;

  String _locationMessage = "Location information loading...";

  @override
  void initState() {
    super.initState();
    futureStocks = fetchStocks();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      print("Service enabled: $serviceEnabled");
      if (!serviceEnabled) {
        setState(() {
          _locationMessage = "Location services off.";
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      print("Permission status: $permission");

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        print("Permission requested: $permission");
        if (permission == LocationPermission.denied) {
          setState(() {
            _locationMessage = "Location permission is denied.";
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _locationMessage =
              "Location permission is permanently denied, please allow it from settings.";
        });
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _locationMessage =
            "Location: ${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}";
      });
      print("Location obtained: $_locationMessage");
    } catch (e) {
      setState(() {
        _locationMessage = "Failed to get location.";
      });
      print("Error getting location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 55,
        backgroundColor: Colors.indigoAccent,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(
              _locationMessage,
              style: TextStyle(fontSize: 12, color: Colors.white70),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 10,
            left: 18,
            right: 18,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Amount Invested",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            Text(
                              "€ 2.240.560",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.arrow_upward,
                              color: Colors.green,
                              size: 15,
                            ),
                            Text(
                              "+%12,2",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.add_circle_outline),
                            Text(
                              " Add New Stock",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Text(
                  "My Portfolio",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 12),
                FutureBuilder<List<Stock>>(
                  future: futureStocks,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Text(
                          "Error loading stocks: ${snapshot.error}",
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text("No stock data available.");
                    }

                    final stocks = snapshot.data!;

                    Map<String, Stock> uniqueStocksMap = {};
                    for (var stock in stocks) {
                      if (!uniqueStocksMap.containsKey(stock.symbol)) {
                        uniqueStocksMap[stock.symbol] = stock;
                      }
                    }
                    List<Stock> uniqueStocks = uniqueStocksMap.values.toList();

                    return Column(
                      children:
                          uniqueStocks.map((stock) {
                            Color cardColor;
                            Color textColor = Colors.white;
                            switch (stock.symbol) {
                              case "AAPL":
                                cardColor = Colors.black;
                                textColor = Colors.white;
                                break;
                              case "THY":
                                cardColor = Colors.red.shade800;
                                textColor = Colors.white;
                                break;
                              case "AMZN":
                                cardColor = Colors.orange.shade400;
                                textColor = Colors.black87;
                                break;
                              default:
                                cardColor = Colors.grey.shade300;
                                textColor = Colors.black87;
                            }
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Widget page;
                                  switch (stock.symbol) {
                                    case "AAPL":
                                      page = AAPLDetailScreen();
                                      break;
                                    case "THY":
                                      page = THYDetailScreen();
                                      break;
                                    case "AMZN":
                                      page = AmazonPage();
                                      break;
                                    default:
                                      page = PortfolioPage();
                                  }
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => page),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: cardColor,
                                    borderRadius: BorderRadius.circular(13),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        color: Colors.black12,
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    leading:
                                        stock.iconUrl.isNotEmpty
                                            ? Image.network(
                                              stock.iconUrl,
                                              width: 36,
                                              height: 36,
                                            )
                                            : null,
                                    title: Text(
                                      stock.symbol,
                                      style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    trailing: Text(
                                      "€ ${stock.price.toStringAsFixed(2)}",
                                      style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                    );
                  },
                ),
                SizedBox(height: 12),
                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "See All Assets →",
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 470,
            left: 14,
            right: 14,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "History",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 12),
                HistoryList(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.indigoAccent,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == _selectedIndex) return;

          setState(() {
            _selectedIndex = index;
          });

          switch (index) {
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PortfolioPage()),
              );

              break;
            case 4:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProfilePage()),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: "Stocks",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_bitcoin),
            label: "Crypto",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "Store"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

class ApplePage extends StatelessWidget {
  const ApplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Apple Inc.")),
      body: Center(child: Text("Apple detay sayfası burada")),
    );
  }
}

class ThyPage extends StatelessWidget {
  const ThyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Turkish Airlines")),
      body: Center(child: Text("THY detay sayfası burada")),
    );
  }
}

class AmazonPage extends StatelessWidget {
  const AmazonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Amazon.com, Inc.")),
      body: Center(child: Text("Amazon ")),
    );
  }
}

class HistoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        historyItem("Buy \"APPL\" Stock", "WED 05 Apr 2025", "€ 20.000", false),
        historyItem("Sell \"APPL\" Stock", "TUE 04 Apr 2025", "€ 20.000", true),
        historyItem("Buy \"APPL\" Stock", "MON 03 Apr 2025", "€ 20.000", false),
      ],
    );
  }

  Widget historyItem(String title, String date, String amount, bool isSell) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSell ? Colors.green : Colors.black,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
          ),
          Text(date, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
        ],
      ),
    );
  }
}
