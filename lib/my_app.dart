import 'package:flutter/material.dart';
import 'package:tasks_app/utils/app_colors.dart';
import 'package:tasks_app/views/sign_in_page.dart';
import 'package:tasks_app/views/splash_screen.dart';
import 'package:tasks_app/views/todos_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: MaterialApp(
          color: Colors.teal,
          debugShowCheckedModeBanner: false,
          title: 'Todos Manager',
          theme: ThemeData(
            fontFamily: "Quicksand",
            useMaterial3: true,
            textTheme: TextTheme(
              titleMedium: TextStyle(
                color: AppColors().TextColor,
                fontSize: 24,
              ),
              bodyMedium: TextStyle(
                color: AppColors().TextColor,
                fontSize: 16,
              ),
              bodySmall: TextStyle(
                fontSize: 12,
              ),
              labelSmall: TextStyle(
                color: AppColors().TextColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
