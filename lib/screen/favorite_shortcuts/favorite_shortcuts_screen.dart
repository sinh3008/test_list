import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:test_list/consts/sizes.dart';

class FavoriteShortcutsScreen extends StatelessWidget {
  const FavoriteShortcutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lối tắt yêu thích'),
      ),
      body: const Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // Outer list
  List<DragAndDropList> _contents = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Generate a list
    _contents = List.generate(2, (index) {
      return DragAndDropList(
        header: Text('Header $index'),
        children: <DragAndDropItem>[
          DragAndDropItem(
            child: Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.all(10),
              color: Colors.orange,
            ),
          ),
        ],
      );
    });
  }

  _onItemReorder(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = _contents[oldListIndex].children.removeAt(oldItemIndex);
      _contents[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = _contents.removeAt(oldListIndex);
      _contents.insert(newListIndex, movedList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(top: 10),
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      child: Column(
        children: [
          const Text('Tạo lối tắt để truy cập các tính năng'
              ' ưa thích dễ dàng hơn tại ngay màn hình chính'),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            width: SizeConfig.screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Chào buổi sáng'),
                const Text(
                  'Mr. Lê Xuân Sinh',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: SizeConfig.screenWidth,
                  height: 400,
                  child: DragAndDropLists(
                    children: _contents,
                    onItemReorder: _onItemReorder,
                    onListReorder: _onListReorder,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
