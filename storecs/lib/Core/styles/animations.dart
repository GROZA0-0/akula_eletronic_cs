import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:storecs/Core/styles/colors.dart';
import 'package:storecs/Core/styles/sizes.dart';

class DrawerIconAnimation extends StatefulWidget {
  final IconData iconData;
  final VoidCallback voidCallback;
  const DrawerIconAnimation({
    super.key,
    required this.iconData,
    required this.voidCallback,
  });

  @override
  State<DrawerIconAnimation> createState() =>
      // ignore: no_logic_in_create_state
      _DrawerIconAnimationState(iconData, voidCallback);
}

class _DrawerIconAnimationState extends State<DrawerIconAnimation>
    with SingleTickerProviderStateMixin {
  final VoidCallback voidCallback;
  final IconData iconData;
  _DrawerIconAnimationState(this.iconData, this.voidCallback);
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
          onTap: voidCallback /* () => Scaffold.of(context).openDrawer() */,
          child: RotationTransition(
            filterQuality: FilterQuality.high,
            alignment: Alignment.center,
            turns: Tween(begin: 0.0, end: 1.1).animate(controller),
            child: Icon(iconData, color: isanimating ? green : white),
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

Widget loadingStateBodies() {
  return Center(child: LoadingAnimationWidget.beat(color: white, size: 55));
}

Widget reportSectionLoading() {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: size.width * 0.01,
      vertical: size.height * 0.01,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: size.height * 0.05,
          width: size.width / 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: grey,
          ),
          child: Text('sedrfgeriogene', style: TextStyle(color: invisible)),
        ),
        sizeBoxHeight(size.height * 0.03),
        Container(
          height: size.height / 2.5,
          width: size.width / 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: grey,
          ),
          child: Text('sedrfgeriogene', style: TextStyle(color: invisible)),
        ),
      ],
    ),
  );
}

final naviStyleToAnotherPage = Transition.rightToLeftWithFade;
final feedbacktNaviRoute = Transition.downToUp;
