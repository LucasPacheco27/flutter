import 'package:flutter/material.dart';

const primaryColor = Color(0xFF4656DD);

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  Widget _newsCard({
    required String title,
    required String imageUrl,
    required String content,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 28),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Görsel
          SizedBox(
            height: 150,
            width: double.infinity,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) => Container(
                          color: Colors.grey[400],
                          child: const Center(
                            child: Icon(
                              Icons.broken_image,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                        ),
                  ),
                ),

                Positioned(
                  left: 8,
                  right: 8,
                  bottom: 8,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.55),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      content,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        height: 1.3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(14, 16, 14, 0),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 0, 16),
            child: Text(
              'Read More →',
              style: TextStyle(
                color: Colors.red.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 2;
    return Scaffold(
      appBar: AppBar(backgroundColor: primaryColor, toolbarHeight: 35),
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today´s News',
                    style: TextStyle(
                      color: Colors.red.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 18),

                  _newsCard(
                    title: 'US Markets Close Higher',
                    imageUrl: 'assets/images/image11.png',
                    content:
                        'All sectors ended the day in positive territory, with materials (+2.88%), technology (+2.56%) and energy (+2.50%) leading the gains...',
                  ),

                  _newsCard(
                    title: 'European Markets Show Strength',
                    imageUrl: 'assets/images/image12.png',
                    content:
                        'European stocks are rising, supported by positive sentiment from global markets...',
                  ),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 78,
            child: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _BottomNavBarItem(
                    icon: Icons.show_chart,
                    label: 'Stock',
                    isSelected: selectedIndex == 0,
                    onTap: () {},
                  ),
                  _BottomNavBarItem(
                    icon: Icons.currency_bitcoin,
                    label: 'Crypto',
                    isSelected: selectedIndex == 1,
                    onTap: () {},
                  ),
                  _BottomNavBarItem(
                    icon: Icons.home_outlined,
                    label: 'Home',
                    isSelected: selectedIndex == 2,
                    onTap: () {},
                  ),
                  _BottomNavBarItem(
                    icon: Icons.store_mall_directory_outlined,
                    label: 'Market',
                    isSelected: selectedIndex == 3,
                    onTap: () {},
                  ),
                  _BottomNavBarItem(
                    icon: Icons.person_2_outlined,
                    label: 'Profile',
                    isSelected: selectedIndex == 4,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _BottomNavBarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: isSelected ? Colors.grey.shade100 : Colors.white,
            border: isSelected ? Border.all(color: Colors.grey.shade300) : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.black : Colors.black54,
                size: 26,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: isSelected ? Colors.black : Colors.black54,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),

              if (isSelected)
                Container(
                  margin: const EdgeInsets.only(top: 3),
                  height: 3,
                  width: 24,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
