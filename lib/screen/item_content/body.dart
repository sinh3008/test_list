import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../blocs/item_bloc.dart';
import '../../consts/const.dart';
import '../../consts/sizes.dart';
import '../../model/item_model.dart';
import '../../repo/items.dart';
import 'item_content_screen.dart';
class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
                      buildDefaultDragHandles: false,
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
          ReorderableDragStartListener(
            index: index,
            child: Icon(
              Icons.drag_indicator,
              color: icon1,
              // color: kIconButtonDefault,
            ),
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
