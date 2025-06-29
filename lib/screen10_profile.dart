import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen15_pro-version.dart';
import 'package:flutter_application_1/screen2.dart';

final Color sectionColor = Color(0xFFE8E9FF);
final Color iconColor = Colors.black87;

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 35, backgroundColor: Colors.indigoAccent),
      backgroundColor: Colors.white,
      bottomNavigationBar: MyBottomNavBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 40,
                      child: IconButton(
                        icon: Icon(
                          Icons.settings,
                          color: Colors.transparent,
                        ), // görünmez
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "My Profile",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      child: IconButton(
                        icon: Icon(Icons.settings, size: 24),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12),

                Row(
                  children: [
                    CircleAvatar(radius: 32, backgroundImage: AssetImage('assets/images/sarah.JPG')),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sarah Wilhem",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "sarah.wilhem@gmail.com",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),

                Text(
                  "Account",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                    color: sectionColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.person, color: iconColor),
                        title: Text("Edit profile"),
                        onTap: () {},
                        contentPadding: EdgeInsets.zero,
                        minLeadingWidth: 0,
                      ),
                      Divider(height: 1),
                      ListTile(
                        leading: Icon(Icons.security, color: iconColor),
                        title: Text("security"),
                        onTap: () {},
                        contentPadding: EdgeInsets.zero,
                        minLeadingWidth: 0,
                      ),
                      Divider(height: 1),
                      ListTile(
                        leading: Icon(
                          Icons.notifications_none,
                          color: iconColor,
                        ),
                        title: Text("Notifications"),
                        onTap: () {},
                        contentPadding: EdgeInsets.zero,
                        minLeadingWidth: 0,
                      ),
                      Divider(height: 1),
                      ListTile(
                        leading: Icon(Icons.lock_outline, color: iconColor),
                        title: Text("Privacy"),
                        onTap: () {},
                        contentPadding: EdgeInsets.zero,
                        minLeadingWidth: 0,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                Text(
                  "Support & Pro Version",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                    color: sectionColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.workspace_premium_outlined,
                          color: iconColor,
                        ),
                        title: Text(
                          "Upgrade to Pro",
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProVPage()),
                          );
                        },
                        contentPadding: EdgeInsets.zero,
                        minLeadingWidth: 0,
                      ),
                      Divider(height: 1),
                      ListTile(
                        leading: Icon(Icons.help_outline, color: iconColor),
                        title: Text("Help & Support"),
                        onTap: () {},
                        contentPadding: EdgeInsets.zero,
                        minLeadingWidth: 0,
                      ),
                      Divider(height: 1),
                      ListTile(
                        leading: Icon(Icons.info_outline, color: iconColor),
                        title: Text("Terms and Policies"),
                        onTap: () {},
                        contentPadding: EdgeInsets.zero,
                        minLeadingWidth: 0,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                Text(
                  "Cache & cellular",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                    color: sectionColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.sd_storage_outlined,
                          color: iconColor,
                        ),
                        title: Text("Free up space"),
                        onTap: () {},
                        contentPadding: EdgeInsets.zero,
                        minLeadingWidth: 0,
                      ),
                      Divider(height: 1),
                      ListTile(
                        leading: Icon(Icons.data_saver_on, color: iconColor),
                        title: Text("Data Saver"),
                        onTap: () {},
                        contentPadding: EdgeInsets.zero,
                        minLeadingWidth: 0,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                ListTile(
                  leading: Icon(Icons.logout, color: Colors.black54),
                  title: Text(
                    "Log out",
                    style: TextStyle(color: Colors.black87),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Screen2()),
                    );
                  },
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyBottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black54,
      backgroundColor: Colors.white,
      showUnselectedLabels: true,

      items: [
        BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Stock'),
        BottomNavigationBarItem(
          icon: Icon(Icons.currency_bitcoin),
          label: 'Crypto',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.store_mall_directory_outlined),
          label: 'Market',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_2_outlined),
          label: 'Profile',
        ),
      ],
    );
  }
}
