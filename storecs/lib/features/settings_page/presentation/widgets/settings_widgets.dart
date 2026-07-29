import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storecs/Core/styles/colors.dart';
import 'package:storecs/Core/styles/sizes.dart';
import 'package:storecs/Core/styles/text_styles.dart';

class SettingsWidgets extends StatefulWidget {
  const SettingsWidgets({super.key});

  @override
  State<SettingsWidgets> createState() => _SettingsWidgetsState();
}

class _SettingsWidgetsState extends State<SettingsWidgets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: invisible,
        iconTheme: IconThemeData(color: white),
        title: FadeInLeft(child: Text('Settings Page', style: textAppBar)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
            decoration: BoxDecoration(
              /* color: redColor, */
              border: Border.all(color: white, width: 4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Column(
                children: [
                  sizeBoxHeight(size.height * 0.003),
                  InventoryAdSerialNumberSettingsSection(),
                  sizeBoxHeight(size.height * 0.01),
                  HardwareAndPeripheralsConfigurationSection(),
                  sizeBoxHeight(size.height * 0.01),
                  PaymentsPricingAndSecuritySection(),
                  sizeBoxHeight(size.height * 0.003),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentsPricingAndSecuritySection extends StatelessWidget {
  const PaymentsPricingAndSecuritySection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListSettingsButtonsComponents(
      title: 'Payments, Pricing, and Security',
      manyWidget: [
        SettingsButtonsComponents(
          title: 'Payment Integrations',
          subtitle:
              'Connects credit/debit card terminals, gift cards, and multi-tender or split-payment options.',
        ),
        sizeBoxHeight(size.height * 0.02),
        SettingsButtonsComponents(
          title: 'Tax Rules',
          subtitle:
              'Sets regional sales tax or VAT, including rules for eco-fees or electronic recycling levies.',
        ),
        sizeBoxHeight(size.height * 0.02),
        SettingsButtonsComponents(
          title: 'Staff Permissions',
          subtitle:
              'Restricts high-level actions like manual price overrides, open-box discounts, or processing returns to manager PIN codes.',
        ),
      ],
    );
  }
}

class HardwareAndPeripheralsConfigurationSection extends StatelessWidget {
  const HardwareAndPeripheralsConfigurationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListSettingsButtonsComponents(
      title: 'Hardware and Peripherals Configuration',
      manyWidget: [
        SettingsButtonsComponents(
          title: 'Barcode & Label Scanners',
          subtitle:
              'Adjusts scanner triggers, key capture delays, and pairing for specialized barcode or QR scanners.',
        ),
        sizeBoxHeight(size.height * 0.02),
        SettingsButtonsComponents(
          title: 'Barcode & Label Scanners',
          subtitle:
              'Adjusts scanner triggers, key capture delays, and pairing for specialized barcode or QR scanners.',
        ),
        sizeBoxHeight(size.height * 0.02),
        SettingsButtonsComponents(
          title: 'Customer-Facing Display',
          subtitle:
              'Toggles second-screen totals, promotional images, or digital signature prompts.',
        ),
      ],
    );
  }
}

class InventoryAdSerialNumberSettingsSection extends StatelessWidget {
  const InventoryAdSerialNumberSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListSettingsButtonsComponents(
      title: 'Inventory and Serial Number Settings',
      manyWidget: [
        SettingsButtonsComponents(
          title: 'Serial Number Capture',
          subtitle:
              'Forces or allows scanning of unique serial numbers/IMEIs during sales and returns to track warranties.',
        ),
        sizeBoxHeight(size.height * 0.02),
        SettingsButtonsComponents(
          title: 'Stock Alerts',
          subtitle:
              'Sets low-stock thresholds for high-demand gadgets or accessories to trigger reorders automatically.',
        ),
        sizeBoxHeight(size.height * 0.02),
        SettingsButtonsComponents(
          title: 'Product Matrix/Attributes',
          subtitle:
              'Configures variants like storage capacity, RAM, color, or carrier locking',
        ),
        sizeBoxHeight(size.height * 0.02),
      ],
    );
  }
}

class ListSettingsButtonsComponents extends StatelessWidget {
  final String title;
  final List<Widget> manyWidget;
  const ListSettingsButtonsComponents({
    super.key,
    required this.manyWidget,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: white, width: 3),
        borderRadius: BorderRadius.circular(12),
        /* color: yellow, */
      ),
      height: size.height / 2,
      width: size.width / 1.1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: EdgeInsets.only(left: size.width * 0.01),
            child: Text(
              title,
              style: GoogleFonts.aleo(
                fontSize: 26,
                color: white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          sizeBoxHeight(size.height * 0.02),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: manyWidget,
          ),
        ],
      ),
    );
  }
}

class SettingsButtonsComponents extends StatelessWidget {
  final String title;
  final String subtitle;
  const SettingsButtonsComponents({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        /* color: greenColor, */
        border: Border.all(color: white, width: 3),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.only(
        left: size.width * 0.012,
        bottom: size.height * 0.002,
      ),
      width: size.width / 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: size.width * 0.01),
            child: Text(
              title,
              style: GoogleFonts.aleo(
                fontSize: 23,
                color: white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: size.width * 0.01),
            child: Text(
              subtitle,
              style: GoogleFonts.aleo(
                color: white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
