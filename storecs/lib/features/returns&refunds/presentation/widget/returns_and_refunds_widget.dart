import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:storecs/Core/config/call_controller.dart';
import 'package:storecs/Core/styles/animations.dart';
import 'package:storecs/Core/styles/colors.dart';
import 'package:storecs/Core/styles/sizes.dart';
import 'package:storecs/Core/styles/text_styles.dart';
import 'package:storecs/features/returns&refunds/presentation/state_management/return_and_refund_controller.dart';

class ReturnsAndRefundsWidget extends StatelessWidget {
  const ReturnsAndRefundsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: invisible,
        title: Text("Returns/Refunds", style: textAppBar),
        iconTheme: IconThemeData(color: white),
      ),
      body: Dialog(
        backgroundColor: white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                        decoration: const InputDecoration(
                          labelText: "Enter Order ID / Scan Receipt Barcode",
                          prefixIcon: Icon(Icons.search),
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

                Obx(() {
                  switch (returnAndRefundController.status.value) {
                    case ReturnStatus.initial:
                      return const SizedBox(
                        height: 250,
                        child: Center(
                          child: Text(
                            "Scan a receipt or enter an Order ID above to start the refund process.",
                            style: TextStyle(color: grey, fontSize: 16),
                          ),
                        ),
                      );

                    case ReturnStatus.loading:
                      return SizedBox(height: 250, child: loadingStateBodies());

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
                }),
              ],
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
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.cancel_outlined, color: Colors.grey),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        const SizedBox(height: 10),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Row(
            children: [
              const Expanded(
                flex: 1,
                child: Text(
                  "S.No.",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 1,

                child: Obx(
                  () => Checkbox(
                    value: controller.isAllSelected,
                    onChanged: (val) =>
                        controller.toggleSelectAll(val ?? false),
                  ),
                ),
              ),
              const Expanded(
                flex: 3,
                child: Text(
                  "Product Name",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const Expanded(
                flex: 1,
                child: Text(
                  "Qty Bought",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const Expanded(
                flex: 1,
                child: Text(
                  "Unit Price",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const Expanded(
                flex: 2,
                child: Text(
                  "Return Quantity",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),

        // --- ORDER ITEMS LIST ---
        Obx(
          () => ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.itemsDetailsModel.length,
            itemBuilder: (context, index) {
              // Re-get item from controller to track its reactive state
              final item = controller.itemsDetailsModel[index];

              return Container(
                color: index % 2 == 0 ? grey : white,
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 16,
                ),
                child: Row(
                  children: [
                    Expanded(flex: 1, child: Text("${index + 1}")),

                    Expanded(
                      flex: 1,
                      child: Checkbox(
                        value: item.isSelected,
                        onChanged: (val) =>
                            controller.itemSection(index, val ?? false),
                      ),
                    ),

                    Expanded(flex: 3, child: Text(item.name)),

                    Expanded(flex: 1, child: Text("${item.quantity}")),

                    Expanded(
                      flex: 1,
                      child: Text("£${item.price.toStringAsFixed(2)}"),
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
                          Text(" / ${item.quantity}"),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text("Restore Quantity to Inventory"),
            Obx(
              () => Checkbox(
                value: controller.restoreInventory.value,
                onChanged: (val) =>
                    controller.restoreInventory.value = val ?? false,
              ),
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
                  Obx(
                    () => Text(
                      "Payment Method: ${controller.paymentMethod.value}",
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Obx(
                    () => Text(
                      "Original Total: ${controller.originalTotal.value.toStringAsFixed(2)} JOD",
                      style: const TextStyle(color: grey),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Obx(
                    () => Text(
                      "Return Amount: £${controller.calculatedReturnAmount.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: greenColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: "Reason for Return (Optional)",
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 2,
                    onChanged: (val) => controller.refundReason.value = val,
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
