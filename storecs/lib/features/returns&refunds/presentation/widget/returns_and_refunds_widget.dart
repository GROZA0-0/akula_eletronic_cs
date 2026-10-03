import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:storecs/Core/config/call_controller.dart';
import 'package:storecs/Core/styles/animations.dart';
import 'package:storecs/Core/styles/colors.dart';
import 'package:storecs/Core/styles/sizes.dart';
import 'package:storecs/Core/styles/text_styles.dart';
import 'package:storecs/features/returns&refunds/presentation/state_management/return_and_refund_controller.dart';

class ReturnsAndRefundsWidget extends StatefulWidget {
  final String fullName;
  const ReturnsAndRefundsWidget({super.key, required this.fullName});

  @override
  State<ReturnsAndRefundsWidget> createState() =>
      _ReturnsAndRefundsWidgetState();
}

class _ReturnsAndRefundsWidgetState extends State<ReturnsAndRefundsWidget> {
  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      returnAndRefundController.orderIdText.clear();
      returnAndRefundController.itemsDetailsModel = [];
      returnAndRefundController.refundReason = '';
      returnAndRefundController.refundItemModel = [];
      returnAndRefundController.restoreInventory = false;
      returnAndRefundController.status = ReturnStatus.initial;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: invisible,
        title: FadeInLeft(child: Text("Returns/Refunds", style: textAppBar)),
        iconTheme: IconThemeData(color: white),
      ),
      body: returnAndRefundBodyMethod(widget.fullName),
    );
  }

  Widget returnAndRefundBodyMethod(String fullName) {
    return FadeInUp(
      child: Dialog(
        backgroundColor: surfaceCardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: white),
        ),
        child: SingleChildScrollView(
          child: Container(
            width: size.width * 0.8,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        cursorColor: black,
                        controller: returnAndRefundController.orderIdText,
                        textAlign: TextAlign.start,

                        style: textBodiesStyle.copyWith(
                          color: grey,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search, color: white),
                          border: OutlineInputBorder(),
                          labelText: 'Enter Order ID / Scan Receipt Barcode',
                          contentPadding: EdgeInsets.zero,
                          labelStyle: textBodiesStyle,
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
                            borderSide: const BorderSide(color: redColor),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: redColor,
                              width: 2,
                            ),
                          ),
                          filled: true,
                          fillColor: invisible,
                        ),
                        maxLines: 1,
                        onFieldSubmitted: (_) => returnAndRefundController
                            .getOrderBySearchingOnOrderId(),
                      ),
                    ),
                    sizeBoxWidth(size.width * 0.012),
                    SaveButton(
                      callback: () => returnAndRefundController
                          .getOrderBySearchingOnOrderId(),
                      height: size.height * 0.07,
                      width: size.width * 0.07,
                      text: 'Search',
                      color: milkyblue,
                    ),
                    // orderSearchButton(),
                  ],
                ),
                sizeBoxHeight(size.height * 0.016),
                const Divider(),
                fetchOrderDataStatusMethod(fullName),
              ],
            ) /* */,
          ),
        ),
      ),
    );
  }

  Widget fetchOrderDataStatusMethod(String fullName) {
    return ListenableBuilder(
      listenable: returnAndRefundController,
      builder: (context, child) {
        switch (returnAndRefundController.status) {
          case ReturnStatus.initial:
            return initialWidgetMethod();

          case ReturnStatus.loading:
            return SizedBox(
              height: size.height * 0.50,
              child: loadingStateBodies(),
            );

          case ReturnStatus.error:
            return couldNotFindOrderWidgetMethod();

          case ReturnStatus.success:
            return BuildSuccessOrderReturnLayout(
              controller: returnAndRefundController,
              fullName: fullName,
            );
        }
      },
    );
  }

  Widget couldNotFindOrderWidgetMethod() {
    return SizedBox(
      height: size.height * 0.50,
      child: Center(
        child: Text(
          "Could not find order. Please verify the ID and try again.",
          style: textBodiesStyle2,
        ),
      ),
    );
  }

  Widget initialWidgetMethod() {
    return SizedBox(
      height: size.height * 0.50,
      child: Center(
        child: Text(
          "Scan a receipt or enter an Order ID above to start the refund process.",
          style: textBodiesStyle,
        ),
      ),
    );
  }

  /* Widget orderSearchButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10),
        ),
        minimumSize: const Size(100, 54),
        backgroundColor: milkyblue,
      ),
      onPressed: () => returnAndRefundController.getOrderBySearchingOnOrderId(),
      icon: const Icon(Iconsax.search_normal_1, color: white),
      label: Text("Search", style: textBodiesStyle),
    );
  } */
}

class BuildSuccessOrderReturnLayout extends StatelessWidget {
  final ReturnAndRefundController controller;
  final String fullName;
  const BuildSuccessOrderReturnLayout({
    super.key,
    required this.controller,
    required this.fullName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        orderIdTextView(),
        sizeBoxHeight(size.height * 0.010),

        rowOfReturnsAndRefundKeysMethod(),

        /* --- ORDER ITEMS LIST --- */
        rowOfReturnsAndRefundDataMethod(),

        sizeBoxHeight(size.height * 0.016),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            coloumnOfPaymentAndOriginalPriceMethod(),

            coloumnOfRefundValueMethod(),
          ],
        ),
        sizeBoxHeight(size.height * 0.016),

        SaveButton(
          callback: () => controller.submitReturn(fullName),
          height: size.height * 0.048,
          width: double.infinity,
          text: "Confirm Return",
          color: redColor,
        ),
      ],
    );
  }

  Widget coloumnOfRefundValueMethod() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "Return Amount: ${controller.calculatedReturnAmount.toStringAsFixed(2)} JOD",
            style: GoogleFonts.aleo(
              fontSize: 18,
              color: greenColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            style: GoogleFonts.aleo(color: grey, fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              labelText: "Reason of Refund",
              labelStyle: GoogleFonts.aleo(
                color: white,
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: const Icon(FontAwesomeIcons.question, color: white),
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
                borderSide: const BorderSide(color: blueGreen, width: 2),
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
            maxLines: 1,
            onChanged: (val) => controller.refundReason = val,
          ),
        ],
      ),
    );
  }

  Widget coloumnOfPaymentAndOriginalPriceMethod() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Method: ${controller.paymentMethod.value}",
            style: GoogleFonts.aleo(color: grey, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Text(
            "Original Total: ${controller.originalTotal.value.toStringAsFixed(2)} JOD",
            style: GoogleFonts.aleo(color: grey, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget rowOfReturnsAndRefundDataMethod() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.itemsDetailsModel.length,
      itemBuilder: (context, index) {
        // Re-get item from controller to track its reactive state
        final item = controller.itemsDetailsModel[index];

        return Container(
          color: index % 2 == 0 ? grey : white,
          padding: EdgeInsets.symmetric(
            vertical: size.height * 0.008,
            horizontal: size.width * 0.016,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  "${index + 1}",
                  style: GoogleFonts.aleo(
                    fontSize: 14,
                    color: surfaceCardColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              Expanded(
                flex: 1,
                child: Checkbox(
                  checkColor: white,
                  activeColor: blueGreen,
                  value: item.isSelected,
                  onChanged: (val) =>
                      controller.itemSection(index, val ?? false),
                ),
              ),

              Expanded(
                flex: 3,
                child: Text(
                  '${item.brand} ${item.name}',
                  style: GoogleFonts.aleo(
                    fontSize: 14,
                    color: surfaceCardColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              Expanded(
                flex: 1,
                child: Text(
                  "${item.quantity}",
                  style: GoogleFonts.aleo(
                    fontSize: 14,
                    color: surfaceCardColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              Expanded(
                flex: 1,
                child: Text(
                  "${item.price.toStringAsFixed(2)} JOD",
                  style: GoogleFonts.aleo(
                    fontSize: 14,
                    color: surfaceCardColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    SizedBox(
                      width: 60,
                      height: 35,
                      child: TextFormField(
                        cursorColor: black,
                        key: ValueKey('${item.id}_$index'),
                        initialValue: item.returnQuantity == 0
                            ? ''
                            : '${item.returnQuantity}',
                        textAlign: TextAlign.center,

                        style: GoogleFonts.aleo(
                          color: grey,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          labelStyle: GoogleFonts.aleo(
                            color: white,
                            fontWeight: FontWeight.w400,
                          ),
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
                              color: black,
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
                            borderSide: const BorderSide(color: redColor),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: redColor,
                              width: 2,
                            ),
                          ),
                          filled: true,
                          fillColor: invisible,
                        ),
                        maxLines: 1,
                        onChanged: (value) {
                          final qty = int.tryParse(value) ?? 0;
                          controller.updateReturnQty(index, qty);
                        },
                      ),
                    ),
                    Text(
                      " / ${item.quantity}",
                      style: GoogleFonts.aleo(
                        fontSize: 14,
                        color: surfaceCardColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget rowOfReturnsAndRefundKeysMethod() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.008,
        horizontal: size.width * 0.016,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              "S.No.",
              style: GoogleFonts.aleo(color: grey, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 1,

            child: Checkbox(
              value: controller.isAllSelected,
              onChanged: (val) => controller.toggleSelectAll(val ?? false),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              "Product Name",
              style: GoogleFonts.aleo(
                color: white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "Qty Bought",
              style: GoogleFonts.aleo(
                color: white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "Unit Price",
              style: GoogleFonts.aleo(
                color: white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "Return Quantity",
              style: GoogleFonts.aleo(
                color: white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget orderIdTextView() {
    return Container(
      margin: EdgeInsets.only(right: size.width * 0.59),
      child: Text(
        "Order Return: #${controller.entities.orderId}",
        style: GoogleFonts.aleo(
          fontSize: 18,
          color: white,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SaveButton extends StatefulWidget {
  final VoidCallback callback;
  final double width, height;
  final String text;

  final Color color;

  const SaveButton({
    super.key,
    required this.callback,
    required this.height,
    required this.width,
    required this.text,

    required this.color,
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
                color: passMouse ? widget.color : white,
                width: 3,
              ),
            ),
            child: Center(
              child: Text(
                widget.text,
                style: GoogleFonts.aleo(
                  color: passMouse ? widget.color : white,
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
