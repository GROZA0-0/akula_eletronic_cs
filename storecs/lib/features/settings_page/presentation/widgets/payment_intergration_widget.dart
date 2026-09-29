import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:storecs/Core/config/call_controller.dart';
import 'package:storecs/Core/styles/colors.dart';
import 'package:storecs/Core/styles/sizes.dart';
import 'package:storecs/Core/styles/text_styles.dart';

class PaymentIntergrationWidget extends StatefulWidget {
  const PaymentIntergrationWidget({super.key});

  @override
  State<PaymentIntergrationWidget> createState() =>
      _PaymentIntergrationWidgetState();
}

class _PaymentIntergrationWidgetState extends State<PaymentIntergrationWidget> {
  bool cardTerminalConnected = false;
  String cardTerminalStatus = 'Not connected';

  @override
  void initState() {
    super.initState();
    paymentIntegrationController.getPayment();
  }

  @override
  void dispose() {
    paymentIntegrationController.giftCardPrefixController.clear();
    paymentIntegrationController.minCardAmountController.clear();
    paymentIntegrationController.allowOptions = {};
    paymentIntegrationController.paymentMethodOptions = {};
    super.dispose();
  }

  void connectCardTerminal() {
    //hook into actual terminal SDK/driver (e.g. Stripe Terminal, Square, Verifone) via USB/serial/network
    setState(() => cardTerminalStatus = 'Searching for terminal...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: invisible,
      appBar: AppBar(
        backgroundColor: invisible,
        iconTheme: IconThemeData(color: white),
        title: FadeInLeft(
          child: Text('Payment Integrations', style: textAppBar),
        ),
      ),
      body: ListenableBuilder(
        listenable: paymentIntegrationController,
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
                      'Connects credit/debit card terminals, gift cards, and multi-tender or split-payment options.',
                      style: textBodiesStyle.copyWith(
                        color: grey,
                        fontSize: 13,
                      ),
                    ),
                    sizeBoxHeight(size.height * 0.02),

                    Text(
                      'Accepted Payment Methods',
                      style: textBodiesStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    sizeBoxHeight(size.height * 0.01),

                    ...paymentIntegrationController.paymentMethodOptions.keys
                        .map((method) {
                          return SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(method, style: textBodiesStyle),
                            value: paymentIntegrationController
                                .paymentMethodOptions[method]!,
                            activeColor: blueGreen,
                            onChanged: (value) => setState(
                              () =>
                                  paymentIntegrationController
                                          .paymentMethodOptions[method] =
                                      value,
                            ),
                          );
                        }),

                    Divider(color: white),
                    sizeBoxHeight(size.height * 0.015),

                    Text(
                      'Card Terminal',
                      style: textBodiesStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    sizeBoxHeight(size.height * 0.01),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Iconsax.card_pos,
                            color: cardTerminalConnected ? greenColor : white,
                          ),
                          sizeBoxWidth(size.width * 0.02),
                          Expanded(
                            child: Text(
                              cardTerminalStatus,
                              style: textBodiesStyle,
                            ),
                          ),
                          TextButton(
                            onPressed: connectCardTerminal,
                            child: Text(
                              'Connect',
                              style: TextStyle(color: blueGreen),
                            ),
                          ),
                        ],
                      ),
                    ),

                    sizeBoxHeight(size.height * 0.015),

                    TextFormField(
                      controller:
                          paymentIntegrationController.minCardAmountController,
                      enabled:
                          paymentIntegrationController
                              .paymentMethodOptions['Credit Or Debt Card Method'] ==
                          true,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      style: textBodiesStyle,
                      decoration: InputDecoration(
                        labelText: 'Minimum amount for card payment (JOD)',
                        labelStyle: TextStyle(color: white),
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
                    ),

                    sizeBoxHeight(size.height * 0.02),

                    Text(
                      'Gift Cards',
                      style: textBodiesStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    sizeBoxHeight(size.height * 0.01),

                    TextFormField(
                      controller:
                          paymentIntegrationController.giftCardPrefixController,
                      enabled:
                          paymentIntegrationController
                              .paymentMethodOptions['Gift Card Method'] ==
                          true,
                      style: textBodiesStyle,
                      decoration: InputDecoration(
                        labelText: 'Gift card code prefix',
                        labelStyle: TextStyle(color: white),
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
                    ),

                    sizeBoxHeight(size.height * 0.02),

                    Text(
                      'Checkout Options',
                      style: textBodiesStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    sizeBoxHeight(size.height * 0.01),

                    ...paymentIntegrationController.allowOptions.keys.map((
                      method,
                    ) {
                      return SwitchListTile(
                        hoverColor: invisible,
                        activeThumbColor: blueGreen,

                        contentPadding: EdgeInsets.zero,
                        title: Text(method, style: textBodiesStyle),
                        subtitle: Text(
                          paymentIntegrationController
                              .checkoutOptionsSubTitle[method],
                          style: textBodiesStyle.copyWith(
                            color: grey,
                            fontSize: 12,
                          ),
                        ),
                        value:
                            paymentIntegrationController.allowOptions[method]!,
                        onChanged: (value) => setState(
                          () =>
                              paymentIntegrationController
                                      .allowOptions[method] =
                                  value,
                        ),
                      );
                    }),
                    sizeBoxHeight(size.height * 0.03),

                    SaveButton(
                      callback: () =>
                          paymentIntegrationController.storePayment(),
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
