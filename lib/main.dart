import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:test_list/model/item_model.dart';
import 'package:test_list/screen/home_screen.dart';

import 'blocs/item_bloc.dart';
import 'consts/sizes.dart';

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
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const App(),
      ),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('App'),
      ),
      body: SizedBox(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        child: Column(
          children: [
            TextButton(
              child: const Text("Flutter"),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
            ),
            Container(
              color: Colors.white12,
              height: SizeConfig.screenHeight * 0.6,
              child: BlocBuilder<ItemBloc, ItemState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => Container(),
                    loading: () => const CircularProgressIndicator(),
                    loaded: (list) => ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return list[index].isActive == true
                            ? Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: listItems[index].isActive
                                      ? Border.all(
                                          color: Colors.green,
                                          width: 1,
                                        )
                                      : Border.all(color: Colors.transparent),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(Icons.drag_indicator),
                                    Text("${listItems[index].name} "),
                                    listItems[index].isActive
                                        ? const Icon(Icons.check_circle)
                                        : const Icon(
                                            Icons.check_circle,
                                            color: Colors.transparent,
                                          ),
                                  ],
                                ),
                              )
                            : Container();
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
