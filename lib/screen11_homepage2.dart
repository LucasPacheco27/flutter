import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen14_news.dart';
import 'package:flutter_application_1/screen9_portfolio.dart';
import 'package:flutter_application_1/screen12_aapl.dart';
import 'package:flutter_application_1/screen13_THY.dart';

class homepage2 extends StatelessWidget {
  const homepage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4656DD);
    const cardBlue = Color(0xFF949CFF);
    const fbBlue = Color(0xFF1877F3);
    const redNews = Color(0xFFD00424);
    const newsCardColor = Color(0xFF202536);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: primaryColor, toolbarHeight: 35),
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
              child: Text(
                'Snapshots',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: cardBlue,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 14,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Amounted Invested",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.93),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "€ 2.240.560 ",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                          ),
                        ),
                        Icon(
                          Icons.arrow_upward,
                          color: Colors.greenAccent,
                          size: 22,
                        ),
                        Text(
                          "+12.2",
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // <<<<<<<<< "What's to buy" başlığındaki "See All →" yazısını tıklanabilir yaptık
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 26, 20, 0),
              child: Row(
                children: [
                  Text(
                    "Hot Stocks",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PortfolioPage(),
                        ),
                      );
                      // Buraya tıklandığında gitmesini istediğin Navigator kodunu yaz.
                      // örn: Navigator.push(context, MaterialPageRoute(builder: (context) => YourPage()));
                    },
                    child: Text(
                      "See All →",
                      style: TextStyle(
                        color: redNews,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AAPLDetailScreen()),
                    );
                    },
                  child: _BuyCard(
                    color: Colors.black,
                    icon: Icons.apple,
                    iconColor: Colors.white,
                    text: "AAPL",
                    textColor: Colors.white,
                  ),
                  ),
                  SizedBox(width: 14),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => THYDetailScreen()),
                      );
                    },
                  child: _BuyCard(
                    color: Color(0xFFD00424),
                    icon: Icons.flight,
                    iconColor: Colors.white,
                    text: "THYA",
                    textColor: Colors.white,
                  ),
                  ),
                  SizedBox(width: 14),

                  _BuyCard(
                    color: fbBlue,
                    fb: true,
                    text: "META",
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: newsCardColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                padding: EdgeInsets.fromLTRB(22, 18, 22, 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today´s News",
                      style: TextStyle(
                        color: redNews,
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    ),
                    SizedBox(height: 13),

                    _NewsItem(
                      title: "US Markets Close Higher",
                      desc:
                          "All sectors ended the day in positive territory, with materials (+2.99%), technology (+2.56%), and energy (+2.50%) leading the gains.",
                    ),
                    Divider(
                      color: Colors.white30,
                      thickness: 1,
                      height: 18,
                      indent: 0,
                      endIndent: 0,
                    ),
                    _NewsItem(
                      title: "European Markets Show Strength",
                      desc:
                          "European stocks are rising, supported by positive sentiment from global markets.",
                    ),
                    Divider(
                      color: Colors.white30,
                      thickness: 1,
                      height: 18,
                      indent: 0,
                      endIndent: 0,
                    ),
                    _NewsItem(
                      title: "Oil Demand Forecast Adjusted",
                      desc:
                          "OPEC has revised its 2025 global oil demand forecast downward from 105.20 million barrels per day to 105.05 million barrels per day, reflecting concerns over economic growth and energy consumption.",
                    ),
                    SizedBox(height: 12),

                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NewsPage()),
                          );
                        },
                        child: Text(
                          "See All →",
                          style: TextStyle(
                            color: redNews,
                            fontWeight: FontWeight.w700,
                            fontSize: 15.5,
                          ),
                        ),
                      ),
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

class _BuyCard extends StatelessWidget {
  final Color color;
  final IconData? icon;
  final Color? iconColor;
  final String text;
  final Color textColor;
  final bool fb;

  const _BuyCard({
    Key? key,
    required this.color,
    this.icon,
    this.iconColor,
    required this.text,
    required this.textColor,
    this.fb = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      height: 92,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          fb
              ? Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.22),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    'f',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                      fontFamily: 'Arial',
                    ),
                  ),
                ),
              )
              : Icon(icon, color: iconColor, size: 34),
          SizedBox(height: 9),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 15.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _NewsItem extends StatelessWidget {
  final String title;
  final String desc;

  const _NewsItem({Key? key, required this.title, required this.desc})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 15.7,
            ),
          ),
          SizedBox(height: 2),
          Text(
            desc,
            style: TextStyle(
              color: Colors.white.withOpacity(0.88),
              fontWeight: FontWeight.w400,
              fontSize: 13.5,
              height: 1.28,
            ),
          ),
        ],
      ),
    );
  }
}
