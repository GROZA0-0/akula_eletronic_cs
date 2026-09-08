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
  const ReturnsAndRefundsWidget({super.key});

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
      body: FadeInUp(
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
                        child: TextField(
                          controller: returnAndRefundController.orderIdText,
                          style: textBodiesStyle,
                          decoration: InputDecoration(
                            labelText: "Enter Order ID / Scan Receipt Barcode",
                            labelStyle: textBodiesStyle,
                            prefixIcon: Icon(Icons.search, color: white),
                            border: OutlineInputBorder(),
                          ),
                          onSubmitted: (_) => returnAndRefundController
                              .getOrderBySearchingOnOrderId(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(10),
                          ),
                          minimumSize: const Size(100, 54),
                          backgroundColor: milkyblue,
                        ),
                        onPressed: () => returnAndRefundController
                            .getOrderBySearchingOnOrderId(),
                        icon: const Icon(Iconsax.search_normal_1, color: white),
                        label: Text("Search", style: textBodiesStyle),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  ListenableBuilder(
                    listenable: returnAndRefundController,
                    builder: (context, child) {
                      switch (returnAndRefundController.status) {
                        case ReturnStatus.initial:
                          return SizedBox(
                            height: 250,
                            child: Center(
                              child: Text(
                                "Scan a receipt or enter an Order ID above to start the refund process.",
                                style: textBodiesStyle,
                              ),
                            ),
                          );

                        case ReturnStatus.loading:
                          return SizedBox(
                            height: 250,
                            child: loadingStateBodies(),
                          );

                        case ReturnStatus.error:
                          return SizedBox(
                            height: 250,
                            child: Center(
                              child: Text(
                                "Could not find order. Please verify the ID and try again.",
                                style: textBodiesStyle2,
                              ),
                            ),
                          );

                        case ReturnStatus.success:
                          return _buildSuccessOrderReturnLayout(
                            context,
                            returnAndRefundController,
                          );
                      }
                    },
                  ),
                ],
              ) /* */,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessOrderReturnLayout(
    BuildContext context,
    ReturnAndRefundController controller,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Order Return: #${controller.entities.orderId}",
              style: GoogleFonts.aleo(
                fontSize: 18,
                color: white,
                fontWeight: FontWeight.w400,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.cancel_outlined, color: grey),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        SizedBox(height: size.height * 0.010),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  "S.No.",
                  style: GoogleFonts.aleo(
                    color: grey,
                    fontWeight: FontWeight.w500,
                  ),
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
        ),

        // --- ORDER ITEMS LIST ---
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.itemsDetailsModel.length,
          itemBuilder: (context, index) {
            // Re-get item from controller to track its reactive state
            final item = controller.itemsDetailsModel[index];

            return Container(
              color: index % 2 == 0 ? grey : white,
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
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
                      value: item.isSelected,
                      onChanged: (val) =>
                          controller.itemSection(index, val ?? false),
                    ),
                  ),

                  Expanded(
                    flex: 3,
                    child: Text(
                      item.name,
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
                            key: ValueKey('${item.id}_$index'),
                            initialValue: item.returnQuantity == 0
                                ? ''
                                : '${item.returnQuantity}',
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(),
                            ),
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
        ),

        const SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text("Restore Quantity to Inventory"),
            Checkbox(
              value: controller.restoreInventory,
              onChanged: (val) => controller.restoreInventory = val ?? false,
            ),
          ],
        ),

        const Divider(),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Payment Method: ${controller.paymentMethod.value}",
                    style: GoogleFonts.aleo(
                      color: grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Original Total: ${controller.originalTotal.value.toStringAsFixed(2)} JOD",
                    style: GoogleFonts.aleo(
                      color: grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
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
                    style: GoogleFonts.aleo(
                      color: grey,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      labelText: "Reason of Refund",
                      labelStyle: GoogleFonts.aleo(
                        color: white,
                        fontWeight: FontWeight.w400,
                      ),
                      prefixIcon: const Icon(
                        FontAwesomeIcons.question,
                        color: white,
                      ),
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
                        borderSide: const BorderSide(color: redColor, width: 2),
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                    ),
                    maxLines: 2,
                    onChanged: (val) => controller.refundReason = val,
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: redColor),
            onPressed: () => controller.submitReturn(),
            child: const Text(
              "Confirm Return",
              style: TextStyle(color: white, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
