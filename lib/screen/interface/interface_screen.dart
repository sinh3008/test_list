import 'package:flutter/material.dart';
import 'package:test_list/screen/interface/body.dart';

import '../../consts/sizes.dart';

class InterfaceScreen extends StatelessWidget {
  const InterfaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Giao diện',
        ),
      ),
      body: const Body(),
    );
  }
}
