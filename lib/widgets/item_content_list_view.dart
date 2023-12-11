import 'package:flutter/material.dart';

class ItemContent extends StatelessWidget {
  const ItemContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.green,
          width: 1,
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.drag_indicator),
          Text("Chỉ số thị trường"),
          Icon(Icons.check_circle),
        ],
      ),
    );
  }
}
