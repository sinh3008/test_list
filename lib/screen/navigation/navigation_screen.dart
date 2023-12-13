import 'package:flutter/material.dart';
import 'body.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Điều hướng ứng dụng'),
      ),
      body: const Body(),
    );
  }
}

