import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../consts/const.dart';
import '../../consts/sizes.dart';
import '../item_content/item_content_screen.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          contentItem(
            context: context,
            icon: Icons.copy_rounded,
            text: 'Nội dung trang chủ',
            iconLate: Icons.navigate_next,
            onPress: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ItemContentScreen(),
                ),
              );
            },
          ),
          contentItem(
            context: context,
            icon: Icons.vertical_distribute,
            text: 'Bố cục trang chủ',
            iconLate: Icons.navigate_next,
            onPress: () {},
          ),
          contentItem(
            context: context,
            icon: Icons.image_outlined,
            text: 'Chủ đề trang chủ',
            iconLate: Icons.navigate_next,
            onPress: () {},
          ),
          contentItem(
            context: context,
            icon: FontAwesomeIcons.nfcDirectional,
            text: 'Điều hướng ứng dụng',
            iconLate: Icons.navigate_next,
            onPress: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) =>  N(),
              //   ),
              // );
            },
          ),
          contentItem(
            context: context,
            icon: Icons.light_mode_outlined,
            text: 'Chế độ màn hình',
            iconLate: Icons.navigate_next,
            onPress: () {},
          ),
        ],
      ),
    );
  }

  GestureDetector contentItem({
    required BuildContext context,
    required IconData icon,
    required String text,
    required IconData iconLate,
    required Function()? onPress,
  }) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: kSurface02,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              color: kIconButtonDefault,
            ),
            Expanded(
              child: Padding(
                padding:
                const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0),
                child: Text(
                  text,
                  textAlign: TextAlign.start,
                  style: TextStyle(color: kBase30),
                ),
              ),
            ),
            Icon(
              iconLate,
              color: kIconButtonDefault,
            )
          ],
        ),
      ),
    );
  }
}
