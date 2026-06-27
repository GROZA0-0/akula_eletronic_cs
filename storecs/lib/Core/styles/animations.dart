import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:storecs/Core/styles/colors.dart';

class DrawerIconAnimation extends StatefulWidget {
  const DrawerIconAnimation({super.key});

  @override
  State<DrawerIconAnimation> createState() => _DrawerIconAnimationState();
}

class _DrawerIconAnimationState extends State<DrawerIconAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool isanimating = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => MouseRegion(
        onEnter: (event) {
          controller.forward();
          setState(() {
            isanimating = true;
          });
        },
        onExit: (event) {
          controller.reverse();
          setState(() {
            isanimating = false;
          });
        },
        child: GestureDetector(
          onTap: () => Scaffold.of(context).openDrawer(),
          child: RotationTransition(
            filterQuality: FilterQuality.high,
            alignment: Alignment.center,
            turns: Tween(begin: 0.0, end: 1.1).animate(controller),
            child: Icon(Iconsax.menu, color: isanimating ? green : white),
          ),
        ),
      ),
    );
  }
}

Widget loadingStateBlocMethod(Size siz) {
  return GridView.builder(
    shrinkWrap: true,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 1,
      crossAxisSpacing: 15.0,
      mainAxisSpacing: 65,
    ),
    itemCount: 1,
    itemBuilder: (context, index) => CardLoading(
      height: siz.height,
      margin: EdgeInsets.symmetric(horizontal: siz.height * 0.005),
      width: siz.width / 1.81,
      borderRadius: const BorderRadius.all(Radius.circular(15)),
    ),
  );
}

final naviStyleToAnotherPage = Transition.rightToLeftWithFade;
