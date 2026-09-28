import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:storecs/Core/config/call_controller.dart';
import 'package:storecs/Core/styles/colors.dart';
import 'package:storecs/Core/styles/sizes.dart';
import 'package:storecs/Core/styles/text_styles.dart';
import 'package:storecs/features/pos_page/presentation/state_management/customer_display_controller.dart';

class CustomerDisplayWidget extends StatefulWidget {
  const CustomerDisplayWidget({super.key});

  @override
  State<CustomerDisplayWidget> createState() => _CustomerDisplayWidgetState();
}

class _CustomerDisplayWidgetState extends State<CustomerDisplayWidget> {
  @override
  void initState() {
    super.initState();
    customerDisplayController.getCustomerScreenSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: invisible,
      appBar: AppBar(
        backgroundColor: invisible,
        iconTheme: IconThemeData(color: white),
        title: FadeInLeft(
          child: Text('Customer-Facing Display', style: textAppBar),
        ),
      ),
      body: ListenableBuilder(
        listenable: customerDisplayController,
        builder: (context, _) {
          return FadeInUp(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                  vertical: size.height * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Toggles second-screen totals, promotional images, or digital signature prompts.',
                      style: TextStyle(color: grey, fontSize: 13),
                    ),
                    sizeBoxHeight(size.height * 0.02),
                    ...customerDisplayController.secondScreenEnabled.keys.map((
                      method,
                    ) {
                      return GestureDetector(
                        child: SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(method, style: textBodiesStyle),
                          subtitle: Text(
                            'Shows a customer-facing display connected to this terminal.',
                            style: TextStyle(color: grey, fontSize: 12),
                          ),
                          value: customerDisplayController
                              .secondScreenEnabled[method]!,
                          activeColor: blueGreen,
                          onChanged: (value) async {
                            setState(
                              () =>
                                  customerDisplayController
                                          .secondScreenEnabled[method] =
                                      value,
                            );
                            await ShowCustomerDisplayController.openCustomerDisplay();
                          },
                        ),
                      );
                    }),

                    Divider(color: white),
                    sizeBoxHeight(size.height * 0.015),

                    Text(
                      'During Checkout',
                      style: textBodiesStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    sizeBoxHeight(size.height * 0.01),
                    ...customerDisplayController.showLiveTotals.keys.map((
                      method,
                    ) {
                      return SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(method, style: textBodiesStyle),
                        value:
                            customerDisplayController.showLiveTotals[method]!,
                        activeColor: blueGreen,
                        onChanged: (value) => setState(
                          () =>
                              customerDisplayController.showLiveTotals[method] =
                                  value,
                        ),
                      );
                    }),
                    ...customerDisplayController.showItemList.keys.map((
                      method,
                    ) {
                      return SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(method, style: textBodiesStyle),
                        value:
                            customerDisplayController.showItemList[method] ??
                            false,
                        activeColor: blueGreen,
                        onChanged: (value) => setState(
                          () => customerDisplayController.showItemList[method] =
                              value,
                        ),
                      );
                    }),

                    sizeBoxHeight(size.height * 0.02),

                    Text(
                      'Digital Signature',
                      style: textBodiesStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    sizeBoxHeight(size.height * 0.01),
                    ...customerDisplayController.requireDigitalSignature.keys
                        .map((method) {
                          return SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(method, style: textBodiesStyle),
                            value:
                                customerDisplayController
                                    .requireDigitalSignature[method] ??
                                false,
                            activeColor: blueGreen,
                            onChanged: (value) => setState(
                              () =>
                                  customerDisplayController
                                          .requireDigitalSignature[method] =
                                      value,
                            ),
                          );
                        }),
                    sizeBoxHeight(size.height * 0.02),

                    Text(
                      'Idle Screen',
                      style: textBodiesStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    sizeBoxHeight(size.height * 0.01),

                    DropdownButtonFormField<String>(
                      value:
                          customerDisplayController.selectedScreenOption.isEmpty
                          ? null
                          : customerDisplayController.selectedScreenOption,
                      dropdownColor: grey,
                      style: textBodiesStyle,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: blueGreen, width: 2),
                        ),
                      ),
                      items: customerDisplayController.idleScreenOptions.map((
                        String option,
                      ) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            customerDisplayController.changeOption(value);
                          });
                        }
                      },
                    ),

                    if (customerDisplayController.idleScreenOptions ==
                        'Promotional Images') ...[
                      sizeBoxHeight(size.height * 0.015),
                      ...customerDisplayController.showPromotionalImages.keys
                          .map((model) {
                            return SwitchListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                'Rotate promotional images',
                                style: textBodiesStyle,
                              ),
                              value: customerDisplayController
                                  .showPromotionalImages[model]!,
                              activeColor: blueGreen,
                              onChanged: (value) => setState(
                                () =>
                                    customerDisplayController
                                            .showPromotionalImages[model] =
                                        value,
                              ),
                            );
                          }),
                      /* if (showPromotionalImages)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton.icon(
                            onPressed: () {
                              // TODO: navigate to a promo image manager / file picker
                            },
                            icon: const Icon(
                              Iconsax.gallery_add,
                              color: blueGreen,
                            ),
                            label: Text(
                              'Manage Images',
                              style: TextStyle(color: blueGreen),
                            ),
                          ),
                        ), */
                    ],
                    sizeBoxHeight(size.height * 0.02),
                    ...customerDisplayController.showThankYouScreen.keys.map((
                      method,
                    ) {
                      return SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          'Show "Thank You" screen after checkout',
                          style: textBodiesStyle,
                        ),
                        value:
                            customerDisplayController
                                .showThankYouScreen[method] ??
                            false,
                        activeColor: blueGreen,
                        onChanged: (value) => setState(
                          () =>
                              customerDisplayController
                                      .showThankYouScreen[method] =
                                  value,
                        ),
                      );
                    }),

                    sizeBoxHeight(size.height * 0.03),

                    SaveButton(
                      callback: () => customerDisplayController
                          .storeCustomerScreenSettings(),
                      height: size.height / 14,
                      width: size.width / 2,
                      text: 'Save',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
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
