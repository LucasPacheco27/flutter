import 'dart:async';
import 'package:flutter/material.dart';
import 'screen2.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {'/screen2': (_) => const Screen2()},
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed('/screen2');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          const HalfCircleBackground(),
          const Center(
            child: ClipOval(
              child: Image(
                image: AssetImage('assets/images/logo.jpg'),
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HalfCircleBackground extends StatelessWidget {
  const HalfCircleBackground({super.key});
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -w * 0.68,
          left: (w - w * 4.5) / 39,
          right: (w - w * 4.5) / 39,
          child: _arc(w * 2, 0.3),
        ),
        Positioned(
          top: -w * 0.36,
          left: (w - w * 1.8) / 3,
          right: (w - w * 1.8) / 3,
          child: _arc(w * 1.8, 0.2),
        ),
        Positioned(
          top: -w * 0.37,
          left: (w - w * 1.6) / 4,
          right: (w - w * 1.6) / 4,
          child: _arc(w * 1.6, 0.1),
        ),
      ],
    );
  }

  Widget _arc(double diameter, double opacity) => Container(
    width: diameter,
    height: diameter / 2,
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(opacity),
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(diameter / 2),
      ),
    ),
  );
}
