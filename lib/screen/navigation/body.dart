import 'package:flutter/material.dart';

import '../../consts/const.dart';
import '../../consts/sizes.dart';
class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: kSurface02,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          buildGestureDetector(
              iconStart: Icons.circle_notifications_outlined,
              iconEnd: Icons.navigate_next,
              title: 'Lối tắt ưa thích',
              content: 'Tuỳ chỉnh lối tắt ưa thích để truy cập'
                  ' các tính năng ưa thích ngay tại trang chủ',
              onPress: () {}),
          const SizedBox(
            height: 30,
          ),
          buildGestureDetector(
              iconStart: Icons.circle_notifications_outlined,
              iconEnd: Icons.navigate_next,
              title: 'Thanh điều hướng',
              content: 'Tuỳ chỉnh thanh điều hướng để truy cập'
                  ' các tính năng ưa thích ở bất cứ đâu',
              onPress: () {}),
        ],
      ),
    );
  }

  GestureDetector buildGestureDetector({
    required IconData iconStart,
    required IconData iconEnd,
    required String title,
    required String content,
    required Function()? onPress,
  }) {
    return GestureDetector(
      onTap: onPress,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              iconStart,
              color: kIconButtonDefault,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Text(
                          content,
                          style: TextStyle(color: kInputFieldDisableBgColor),
                        ),
                      ),
                    ),
                    Icon(
                      iconEnd,
                      color: kIconButtonDefault,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
