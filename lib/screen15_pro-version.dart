import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen16_payment.dart';

class ProVPage extends StatelessWidget {
  const ProVPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 35, backgroundColor: Colors.indigoAccent),

      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      const Spacer(),

                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.settings, size: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'PRICING TABLE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 18),

                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    children: [
                      _PricingCard(
                        title: 'Personal',
                        price: '€ 35',
                        description:
                            'Real-time stock quotes, 1 Watchlist, Daily news summary, Limited technical indicators.',
                        isHighlighted: false,
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => Payment()),
                            ),
                      ),
                      const SizedBox(height: 24),

                      _PricingCard(
                        title: 'Business',
                        price: '€ 55',
                        description:
                            'All in Basic Trader, Unlimited watchlists, Advanced chart tools, Custom alerts, Portfolio tracking',
                        isHighlighted: true,
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => Payment()),
                            ),
                      ),
                      const SizedBox(height: 24),

                      _PricingCard(
                        title: 'Expert',
                        price: '€ 75',
                        description:
                            'All Pro features, Priority customer support, AI-based stock suggestions, Insider trading insights Market sentiment analytics',
                        isHighlighted: false,
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => Payment()),
                            ),
                      ),
                    ],
                  ),
                ),

                const _BottomNavBar(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PricingCard extends StatelessWidget {
  final String title;
  final String price;
  final String description;
  final bool isHighlighted;
  final VoidCallback onTap;

  const _PricingCard({
    required this.title,
    required this.price,
    required this.description,
    required this.isHighlighted,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor =
        isHighlighted ? const Color(0xFF8356F8) : Colors.grey.shade100;
    final textColor = isHighlighted ? Colors.white : Colors.black87;
    final descColor = isHighlighted ? Colors.white70 : Colors.black54;

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow:
            isHighlighted
                ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ]
                : [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: textColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Get the party started.',
              style: TextStyle(fontSize: 14, color: descColor),
            ),
            const SizedBox(height: 18),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: textColor,
                  ),
                ),
                const SizedBox(width: 6),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    'PER MONTH',
                    style: TextStyle(
                      fontSize: 12,
                      color: descColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(description, style: TextStyle(fontSize: 13, color: descColor)),
            const SizedBox(height: 18),
            Center(
              child: SizedBox(
                width: 150,
                height: 34,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isHighlighted ? Colors.white : const Color(0xFF8356F8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: onTap,
                  child: Text(
                    'GET STARTED >',
                    style: TextStyle(
                      color:
                          isHighlighted
                              ? const Color(0xFF8356F8)
                              : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 1.1,
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

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavBarIcon(Icons.show_chart, 'Stock', isSelected: false),
          _NavBarIcon(Icons.currency_bitcoin, 'Crypto', isSelected: false),
          _NavBarIcon(Icons.home, 'Home', isSelected: true),
          _NavBarIcon(Icons.store, 'Market', isSelected: false),
          _NavBarIcon(Icons.person, 'Profile', isSelected: false),
        ],
      ),
    );
  }
}

class _NavBarIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const _NavBarIcon(this.icon, this.label, {this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 28,
          color: isSelected ? const Color(0xFF8356F8) : Colors.black54,
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: isSelected ? const Color(0xFF8356F8) : Colors.black54,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
