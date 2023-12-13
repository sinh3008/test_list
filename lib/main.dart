import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:test_list/consts/const.dart';
import 'package:test_list/screen/interface/interface_screen.dart';

import 'blocs/item_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: kSurface01,
          appBarTheme: AppBarTheme(color: kSurface01),
        ),
        home: const InterfaceScreen(),
      ),
    );
  }
}
