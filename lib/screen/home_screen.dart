import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_list/model/item_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Nội dung trang chủ"),
          centerTitle: true,
        ),
        body: const ReorderableExample());
  }
}

class ReorderableExample extends StatefulWidget {
  const ReorderableExample({super.key});

  @override
  State<ReorderableExample> createState() => _ReorderableListViewExampleState();
}

class _ReorderableListViewExampleState extends State<ReorderableExample> {
  final List<ItemModel> listItems = [
    ItemModel('Danh mục yêu thích', true),
    ItemModel('Danh mục yêu thích', true),
    ItemModel('Danh mục yêu thích', true),
    ItemModel('Danh mục yêu thích', false),
    ItemModel('Danh mục yêu thích', false),
    ItemModel('Danh mục yêu thích', false),
    ItemModel('Danh mục yêu thích', false),
    ItemModel('Danh mục yêu thích', false),
    ItemModel('Danh mục yêu thích', false),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget proxyDecorator(
        Widget child, int index, Animation<double> animation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          return itemList(null);
        },
        child: child,
      );
    }

    return ReorderableListView(
      buildDefaultDragHandles: true,
      proxyDecorator: proxyDecorator,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      children: <Widget>[
        for (int index = 0; index < listItems.length; index += 1)
          GestureDetector(
            key: Key('$index'),
            onTap: () {
              listItems[index].isActive = !listItems[index].isActive;
              setState(() {});
            },
            child: Container(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.drag_indicator),
                  Text("${listItems[index].name} $index"),
                  listItems[index].isActive
                      ? const Icon(Icons.check_circle)
                      : const Icon(
                          Icons.check_circle,
                          color: Colors.transparent,
                        ),
                ],
              ),
            ),
          )
      ],
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final ItemModel item = listItems.removeAt(oldIndex);
          listItems.insert(newIndex, item);
        });
      },
    );
  }

  Container itemList(Key? key) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.drag_indicator, color: Colors.white38,),
          Text(
            "Chỉ số thị trường",
            style: TextStyle(color: Colors.lightGreen),
            textAlign: TextAlign.center,
          ),
          Icon(Icons.check_circle),
        ],
      ),
    );
  }
}
