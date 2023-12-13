import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_list/blocs/item_bloc.dart';
import 'package:test_list/model/item_model.dart';
import 'body.dart';

import '../../consts/const.dart';

List<ItemModel> listItems = [];

class ItemContentScreen extends StatelessWidget {
  const ItemContentScreen({Key? key}) : super(key: key);

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
            title: const Text(
              "Nội dung trang chủ",
            ),
          ),
          body: const Body()),
    );
  }
}
