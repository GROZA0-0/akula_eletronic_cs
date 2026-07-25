import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:storecs/Core/config/call_controller.dart';
import 'package:storecs/Core/styles/colors.dart';
import 'package:storecs/Core/styles/sizes.dart';
import 'package:storecs/Core/styles/text_styles.dart';

class ReportWidget extends StatefulWidget {
  const ReportWidget({super.key});

  @override
  State<ReportWidget> createState() => _ReportWidgetState();
}

class _ReportWidgetState extends State<ReportWidget> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: invisible,
        title: FadeInLeft(child: Text("Sales Reports", style: textAppBar)),
        iconTheme: IconThemeData(color: white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FadeInUp(
            child: Center(
              child: Column(
                children: [
                  ReportFieldTemplate(
                    text: 'Title',
                    icon: Icon(Iconsax.ticket, color: white),
                    controller: reportController.title,
                    lines: 1,
                    txtFieldSize: size.height / 10,
                  ),
                  ReportFieldTemplate(
                    text: 'SubTitle',
                    icon: Icon(Iconsax.ticket, color: white),
                    controller: reportController.subTitle,
                    lines: 200,
                    txtFieldSize: size.height / 2,
                  ),
                  reportStoreMethod(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  MouseRegion reportStoreMethod() {
    return MouseRegion(
      onExit: (event) => setState(() => isHovered = false),
      onEnter: (event) => setState(() => isHovered = true),
      child: InkWell(
        onTap: () => reportController.storeReport(),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: isHovered ? green : white, width: 3),
            borderRadius: BorderRadius.circular(10),
          ),
          width: size.width * 0.4,
          height: size.height * 0.05,
          child: Center(
            child: Text("Create an Account", style: textStyleForButtons(24)),
          ),
        ),
      ),
    );
  }
}

class ReportFieldTemplate extends StatelessWidget {
  const ReportFieldTemplate({
    super.key,
    required this.text,
    required this.icon,
    required this.controller,
    required this.lines,
    required this.txtFieldSize,
  });
  final String text;
  final Icon icon;
  final TextEditingController controller;
  final int lines;
  final double txtFieldSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.020,
        vertical: size.height * 0.030,
      ),
      width: size.width / 1.2,
      height: txtFieldSize /* size.height / 10 */,
      child: TextFormField(
        maxLines: lines,
        controller: controller,
        style: textBodiesStyle,
        decoration: InputDecoration(
          labelText: text,
          labelStyle: GoogleFonts.aleo(
            color: white,
            fontSize: 30,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: white, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: white, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: greenColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: redColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: redColor, width: 2),
          ),
          filled: true,
          fillColor: Colors.transparent,
        ),
      ),
    );
  }
}
