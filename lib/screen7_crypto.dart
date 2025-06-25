import 'package:flutter/material.dart';

class CryptoScreen extends StatelessWidget {
  const CryptoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4656DD);
    const redNews = Color(0xFFD00424);
    const bgNews = Color(0xFF202536);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        toolbarHeight: 35,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Field
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFEDEBFF),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                children: const [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 8),
                  Text("Search Cripto", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Crypto list
            _cryptoItem(
              "BTC🔥",
              "Bitcoin",
              "₽ 3 425 524,0",
              "+3,25%",
              Colors.orange,
              true,
            ),
            _cryptoItem(
              "ETH🔥",
              "Ethereum",
              "₽ 189 584,7",
              "+6,66%",
              Colors.green,
              true,
            ),
            _cryptoItem(
              "MATIC",
              "Polygon",
              "₽ 76,0",
              "+1,77%",
              Colors.green,
              false,
            ),
            _cryptoItem(
              "XMY",
              "Myriad",
              "₽ 0,006455",
              "-0.01%",
              Colors.red,
              false,
            ),
            _cryptoItem(
              "XRP🔥",
              "Ripple",
              "₽ 61,9",
              "-4,31%",
              Colors.red,
              true,
            ),

            const SizedBox(height: 20),
            Center(
              child: Text(
                "See All Assets →",
                style: TextStyle(
                  color: redNews,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // News section
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: bgNews,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Today´s News",
                    style: TextStyle(
                      color: redNews,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 14),
                  _NewsItem(
                    title:
                        "Bitcoin hits \$94,000 as ETF inflows surge to record levels.",
                    desc:
                        "Investors are flooding into Bitcoin ETFs, pushing the price to new highs.",
                  ),
                  Divider(color: Colors.white24),
                  _NewsItem(
                    title: "Ethereum ETF sees zero inflow for the day.",
                    desc:
                        "Grayscale’s ETHE records no investor inflows, signaling caution in the market.",
                  ),
                  Divider(color: Colors.white24),
                  _NewsItem(
                    title:
                        "Coinbase removes fees for PayPal's PYUSD stablecoin.",
                    desc:
                        "This move aims to boost adoption of PYUSD in everyday crypto payments.",
                  ),
                  SizedBox(height: 12),
                  Center(
                    child: Text(
                      "See All →",
                      style: TextStyle(
                        color: redNews,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cryptoItem(
    String symbol,
    String name,
    String price,
    String change,
    Color color,
    bool isBoldIcon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8FF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.2),
            child: Text(symbol.substring(0, 1), style: TextStyle(color: color)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  symbol,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(name, style: const TextStyle(color: Colors.black54)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                change,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.5,
                ),
              ),
              Text(
                price,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NewsItem extends StatelessWidget {
  final String title;
  final String desc;
  const _NewsItem({required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            desc,
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: 13.5,
            ),
          ),
        ],
      ),
    );
  }
}
