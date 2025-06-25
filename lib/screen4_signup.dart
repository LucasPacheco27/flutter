import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen2.dart';

import 'screen5_homepage.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<Signup> {
  bool agreeTerms = false;
  bool subscribeUpdates = false;
  String? selectedSource;

  final List<String> sources = ['Instagram', 'Friend', 'Google', 'Other'];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(toolbarHeight: 10, backgroundColor: Colors.indigoAccent),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 22,
            left: 35,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Screen2()),
                );
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 22,
              ),
            ),
          ),

          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: Column(
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/images/logo.jpg',
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 120,
            left: 24,
            right: 24,
            child: Container(
              width: width - 48,
              decoration: BoxDecoration(
                color: Color(0xFFE5E6FA),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 12,
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Personal Information",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),

                  TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: "Country/Region",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: "Birthday",
                      hintStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: Text('How did you hear about TrackVest?'),
                        value: selectedSource,
                        items:
                            sources
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedSource = val;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  Row(
                    children: [
                      Checkbox(
                        value: agreeTerms,
                        onChanged: (val) {
                          setState(() => agreeTerms = val ?? false);
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() => agreeTerms = !agreeTerms);
                          },
                          child: Text(
                            'I agree to the Terms and Conditions',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Checkbox(
                        value: subscribeUpdates,
                        onChanged: (val) {
                          setState(() => subscribeUpdates = val ?? false);
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(
                              () => subscribeUpdates = !subscribeUpdates,
                            );
                          },
                          child: Text(
                            'Subscribe to receive updates and\nmarket news via email.',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 4,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        width: 150,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 30,
            left: 50,
            right: 50,
            child: SizedBox(
              width: 30,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF625DF5),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),

                  minimumSize: Size(double.infinity, 30),
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
