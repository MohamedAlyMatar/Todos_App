import 'package:flutter/material.dart';
import 'package:tasks_app/views/sign_in_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInPage()),
      );
    });
    return Scaffold(
        backgroundColor: const Color.fromRGBO(0, 0, 88, 1),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset('assets/logos/link_you_logo.png'),
            const SizedBox(height: 12),
            const Text("Flutter Assessment",
                style: TextStyle(color: Colors.white)),
            const Text("Loading Todo Manager",
                style: TextStyle(color: Colors.white)),
            const SizedBox(height: 12),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ]),
        ));
  }
}
