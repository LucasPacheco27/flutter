import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen10_profile.dart';
import 'package:flutter_application_1/screen11_homepage2.dart';

class HomePage extends StatefulWidget {
  // <--- Burada Stateless yerine StatefulWidget kullandık!
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    switch (index) {
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4656DD);
    const goldColor = Color(0xFFFFD700);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: primaryColor, toolbarHeight: 35),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: "Stock"),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_bitcoin),
            label: "Crypto",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront),
            label: "Market",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/homescreen.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(color: Colors.black.withOpacity(0.4)),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome to Trackvest!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            shadows: [
                              Shadow(
                                blurRadius: 10,
                                color: Colors.black45,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 18.0,
                top: 10.0,
                right: 18.0,
              ),
              child: Text(
                "Hi, Sarah",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 8.0,
              ),
              child: Divider(color: Colors.black, thickness: 1, height: 10),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                children: [
                  Text(
                    "Trending Stocks",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      height: 2,
                    ),
                  ),
                  Icon(Icons.trending_up, size: 20),
                  Spacer(),
                  Text(
                    "Refresh",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.refresh, size: 18, color: primaryColor),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 1),
              child: Column(
                children: [
                  _TrendingStockTile(
                    icon: Icons.account_balance,
                    iconColor: goldColor,
                    title: "GOLD",
                    subtitle: "The most purchased in the last week",
                    price: "260,50 €",
                  ),
                  SizedBox(height: 6),
                  _TrendingStockTile(
                    image: Image.asset(
                      'assets/images/amazon.png',
                      width: 30,
                      height: 30,
                    ),
                    title: "AMZN",
                    subtitle: "The most added to the watchlist",
                    price: "173,50 €",
                  ),
                  SizedBox(height: 6),
                  _TrendingStockTile(
                    icon: Icons.currency_bitcoin,
                    iconColor: Colors.black,
                    title: "BTC",
                    subtitle: "Recommended from analysts",
                    price: "75.000 €",
                  ),
                ],
              ),
            ),
            const Spacer(),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 18.0,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => homepage2()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  child: Text(
                    "Get Started >",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
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

class _TrendingStockTile extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final Widget? image;
  final String title;
  final String subtitle;
  final String price;

  const _TrendingStockTile({
    Key? key,
    this.icon,
    this.iconColor,
    this.image,
    required this.title,
    required this.subtitle,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.8,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        child: Row(
          children: [
            if (icon != null)
              Icon(icon, color: iconColor ?? Colors.black, size: 26)
            else if (image != null)
              image!
            else
              SizedBox(width: 26),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12.5, color: Colors.black54),
                  ),
                ],
              ),
            ),
            Text(
              price,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
