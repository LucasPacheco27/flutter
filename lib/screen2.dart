import 'package:flutter/material.dart';
import 'screen4_signup.dart';
import 'main.dart';
import 'screen3_login.dart';

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(toolbarHeight: 10, backgroundColor: Colors.indigoAccent),
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            const HalfCircleBackground(),

            Positioned(
              bottom: -w * 0.3,
              left: -150,
              right: -80,
              child: Transform.rotate(
                angle: -0.30,
                origin: Offset(0, 0),
                child: Container(
                  height: w * 1,
                  color: Colors.indigoAccent.withOpacity(0.1),
                ),
              ),
            ),

            Column(
              children: [
                SizedBox(height: 250),

                Center(
                  child: Transform.translate(
                    offset: const Offset(0, -125),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFAFAF8),
                        shape: BoxShape.circle,
                      ),

                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/logo.jpg',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 40),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: const [
                      Text(
                        'Welcome to Trackvest!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'With Trackvest, you can easily invest in global stock markets, '
                        'including the U.S., European, and Asian exchanges — all with no '
                        'account maintenance fees.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, height: 1.4),
                      ),
                    ],
                  ),
                ),

                Spacer(),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 300,
                        height: 48,
                        child: ElevatedButton(
                          onPressed:
                              () => Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) => const Login(),
                                ),
                              ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigoAccent,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text('LOG IN'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: 300,
                        height: 48,
                        child: OutlinedButton(
                          onPressed:
                              () => Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) => const Signup(),
                                ),
                              ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.indigoAccent,
                            side: const BorderSide(color: Colors.indigoAccent),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text('SIGN UP'),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
