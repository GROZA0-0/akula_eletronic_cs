import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storecs/Core/config/call_controller.dart';
import 'package:storecs/Core/styles/colors.dart';
import 'package:storecs/Core/styles/sizes.dart';
import 'package:storecs/Core/styles/text_styles.dart';

class StockAlertsWidget extends StatefulWidget {
  const StockAlertsWidget({super.key});

  @override
  State<StockAlertsWidget> createState() => _StockAlertsWidgetState();
}

class _StockAlertsWidgetState extends State<StockAlertsWidget> {
  bool alertsEnabled = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      stockAlertsController.getThreSholdAlerts();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (final controller
          in stockAlertsController.thresholdController.values) {
        controller.clear();
      }
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: invisible,
      appBar: AppBar(
        backgroundColor: invisible,
        iconTheme: IconThemeData(color: white),
        title: FadeInLeft(child: Text('Stock Alerts Page', style: textAppBar)),
      ),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: stockAlertsController,
          builder: (context, _) {
            return FadeInUp(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                  vertical: size.height * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sets low-stock thresholds for high-demand gadgets or accessories to trigger reorders automatically.',
                      style: GoogleFonts.aleo(
                        color: grey,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    sizeBoxHeight(size.height * 0.02),

                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Enable Stock Alerts',
                        style: textBodiesStyle,
                      ),
                      value: alertsEnabled,
                      activeColor: blueGreen,
                      onChanged: (value) =>
                          setState(() => alertsEnabled = value),
                    ),

                    Divider(color: white),
                    sizeBoxHeight(size.height * 0.015),

                    Text(
                      'Category Thresholds',
                      style: textBodiesStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    sizeBoxHeight(size.height * 0.01),

                    ...stockAlertsController.thresholdController.entries.map((
                      entry,
                    ) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: size.height * 0.015),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(entry.key, style: textBodiesStyle),
                            ),
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                controller: entry.value,
                                style: textBodiesStyle,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: white,
                                      width: 2,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: white,
                                      width: 2,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: blueGreen,
                                      width: 2,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: redColor,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: redColor,
                                      width: 2,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.transparent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),

                    sizeBoxHeight(size.height * 0.03),

                    SaveButton(
                      callback: () async =>
                          await stockAlertsController.storeThreSholdAlerts(),
                      height: size.height / 14,
                      width: size.width / 2,
                      text: 'Save',
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SaveButton extends StatefulWidget {
  final VoidCallback callback;
  final double width, height;
  final String text;

  const SaveButton({
    super.key,
    required this.callback,
    required this.height,
    required this.width,
    required this.text,
  });

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  bool passMouse = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MouseRegion(
        onEnter: (event) => setState(() => passMouse = true),
        onExit: (event) => setState(() => passMouse = false),
        child: InkWell(
          splashColor: invisible,
          onTap: widget.callback,
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: passMouse ? blueGreen : white,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                widget.text,
                style: GoogleFonts.aleo(
                  color: passMouse ? blueGreen : white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
