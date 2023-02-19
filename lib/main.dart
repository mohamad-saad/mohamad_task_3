import 'package:flutter/material.dart';
import 'package:mohamad_task_3/splash_screen.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: "/splashscreen",
    routes: {
      '/splashscreen': (context) => const SplashScreen(),
    },
  ));
}
