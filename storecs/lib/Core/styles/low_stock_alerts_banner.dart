import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storecs/Core/config/call_controller.dart';
import 'package:storecs/Core/styles/colors.dart';
import 'package:storecs/Core/styles/sizes.dart';

class LowStockAlertsBanner extends StatelessWidget {
  const LowStockAlertsBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: stockAlertsController,
      builder: (context, _) {
        if (stockAlertsController.isLoading) {
          return const LinearProgressIndicator();
        }

        if (stockAlertsController.lowStockItems.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          decoration: BoxDecoration(
            color: redColor,
            border: Border.all(color: white),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          margin: EdgeInsets.only(right: size.width * 0.8),
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: white),
              SizedBox(width: size.width * 0.008),
              Expanded(
                child: Text(
                  '${stockAlertsController.lowStockItems.length} items are low on stock!',
                  style: GoogleFonts.aleo(
                    color: white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
