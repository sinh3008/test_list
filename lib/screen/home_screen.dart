import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_list/blocs/item_bloc.dart';
import 'package:test_list/consts/sizes.dart';
import 'package:test_list/model/item_model.dart';
import 'package:test_list/repo/items.dart';

import '../consts/const.dart';

List<ItemModel> listItems = [];

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void showOverlay(BuildContext context, String title) {
    OverlayEntry overlayEntry;
    final double appBarHeight = AppBar().preferredSize.height;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: appBarHeight - MediaQuery.of(context).padding.top,
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            height: 50,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    Future.delayed(const Duration(seconds: 1), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
          backgroundColor: kSurface01,
          appBar: AppBar(
            backgroundColor: kSurface01,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: kIconButtonDefault,
              ),
              onPressed: () {
                int number = 0;
                for (var data in listItems) {
                  if (data.isActive == true) {
                    number += 1;
                  }
                }
                if (number >= 3 && number <= 7) {
                  Navigator.of(context).pop(context);
                  context.read<ItemBloc>().add(ItemEvent.started(listItems));
                } else {
                  if (number < 3) {
                    showOverlay(context, "Không đủ nội dung tối thiểu (3)");
                  } else if (number > 7) {
                    showOverlay(context, "Vượt quá nội dung tối đa (7)");
                  }
                }
              },
            ),
            title: Text(
              "Nội dung trang chủ",
              style: TextStyle(color: kTitleSectionHeader, fontSize: 30),
            ),
            centerTitle: true,
          ),
          body: const ReorderableExample()),
    );
  }
}

class ReorderableExample extends StatefulWidget {
  const ReorderableExample({super.key});

  @override
  State<ReorderableExample> createState() => _ReorderableListViewExampleState();
}

class _ReorderableListViewExampleState extends State<ReorderableExample> {
  late SharedPreferences prefs;
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    context.read<ItemBloc>().add(ItemEvent.started(listItems));
    loadListFromSharedPreferences();
  }

  Future<List<ItemModel>> loadListFromSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String? jsonString = sharedPreferences.getString(item_list);
    if (jsonString != null) {
      final List jsonDecoded = jsonDecode(jsonString) as List;
      listItems = jsonDecoded.map((e) => ItemModel.fromJson(e)).toList();
      listItems.sort((a, b) => a.isActive == b.isActive
          ? 0
          : a.isActive
              ? -1
              : 1);
      return listItems;
    } else {
      return listItems = [
        ItemModel(name: 'Danh mục yêu thích', isActive: true),
        ItemModel(name: 'Tin tức sự kiện', isActive: true),
        ItemModel(name: 'Bản đồ nhiệt', isActive: true),
        ItemModel(name: 'Chỉ số thị trường', isActive: false),
        ItemModel(name: 'Tài sản', isActive: false),
        ItemModel(name: 'Nhóm cổ phiếu', isActive: false),
        ItemModel(name: 'Khuyến nghị đầu tư', isActive: false),
        ItemModel(name: 'Danh sách sở hữu', isActive: false),
        ItemModel(name: 'Hiệu quả đầu tư', isActive: false),
        ItemModel(name: 'Cổ phiếu đột biến', isActive: false),
        ItemModel(name: 'Sợ hãi & Tham lam', isActive: false),
        ItemModel(name: 'Nhóm cổ phiếu 1', isActive: false),
        ItemModel(name: 'Khuyến nghị đầu tư 1', isActive: false),
        ItemModel(name: 'Danh sách sở hữu 1', isActive: false),
        ItemModel(name: 'Hiệu quả đầu tư 1', isActive: false),
        ItemModel(name: 'Cổ phiếu đột biến 1', isActive: false),
        ItemModel(name: 'Sợ hãi & Tham lam 1', isActive: false),
      ];
    }
  }

  Future<void> saveListToSharedPreferences(List<ItemModel> list) async {
    final String jsonString = json.encode(list);
    sharedPreferences.setString('item_list', jsonString);
  }

  @override
  Widget build(BuildContext context) {
    Widget proxyDecorator(
        Widget child, int index, Animation<double> animation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          return buildContainer(
            index: index,
            color: kHoverButton,
            icon1: Colors.transparent,
            icon2: Colors.transparent,
            textColor: kTextInFieldColor.withOpacity(0.3),
          );
        },
        child: child,
      );
    }

    return SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: kSurface01,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
            child: Text(
              'Lựa chọn tối đa 07 nội dung bạn quan tâm nhất để hiển thị trên màn hình chinh',
              style: TextStyle(color: kTitleSectionHeader),
            ),
          ),
          BlocBuilder<ItemBloc, ItemState>(
            builder: (context, state) {
              return state.when(
                  initial: () => Container(),
                  loading: () => const CircularProgressIndicator(),
                  loaded: (lis) => SizedBox(
                        height: SizeConfig.screenHeight * 0.8,
                        child: ReorderableListView(
                          buildDefaultDragHandles: true,
                          proxyDecorator: proxyDecorator,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          children: <Widget>[
                            for (int index = 0;
                                index < listItems.length;
                                index += 1)
                              GestureDetector(
                                key: Key('$index'),
                                onTap: () {
                                  listItems[index] = listItems[index].copyWith(
                                      isActive: !listItems[index].isActive);
                                  setState(() {});
                                  saveListToSharedPreferences(listItems);
                                },
                                child: buildContainer(
                                    index: index,
                                    color: kSurface02,
                                    icon1: kIconButtonDefault,
                                    icon2: kButtonBgDefault,
                                    textColor: kTextInFieldColor),
                              )
                          ],
                          onReorder: (int oldIndex, int newIndex) {
                            setState(() {
                              if (oldIndex < newIndex) {
                                newIndex -= 1;
                              }
                              final ItemModel item =
                                  listItems.removeAt(oldIndex);
                              listItems.insert(newIndex, item);
                            });
                            saveListToSharedPreferences(listItems);
                          },
                        ),
                      ));
            },
          ),
        ],
      ),
    );
  }

  Container buildContainer(
      {required int index,
      required Color color,
      required Color icon1,
      required Color icon2,
      required Color textColor}) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        // color: kSurface02,
        color: color,
        borderRadius: BorderRadius.circular(15),
        border: listItems[index].isActive
            ? Border.all(
                color: kInputFieldSuccessColor,
                width: 1,
              )
            : Border.all(color: Colors.transparent),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.drag_indicator,
            color: icon1,
            // color: kIconButtonDefault,
          ),
          Text(
            "${listItems[index].name} ",
            style: TextStyle(color: textColor),
          ),
          listItems[index].isActive
              ? Icon(
                  Icons.check_circle,
                  color: icon2,
                  // color: kButtonBgDefault,
                )
              : const Icon(
                  Icons.check_circle,
                  color: Colors.transparent,
                ),
        ],
      ),
    );
  }
}
