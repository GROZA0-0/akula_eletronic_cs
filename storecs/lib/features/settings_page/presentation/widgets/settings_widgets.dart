import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:storecs/Core/styles/animations.dart';
import 'package:storecs/Core/styles/colors.dart';
import 'package:storecs/Core/styles/sizes.dart';
import 'package:storecs/Core/styles/text_styles.dart';
import 'package:storecs/features/settings_page/presentation/page/tax_rules.dart';

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
        elevation: 0,
        iconTheme: const IconThemeData(color: white),
        title: FadeInLeft(child: Text('Settings Page', style: textAppBar)),
      ),
      body: FadeInUp(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                InventoryAndSerialNumberSettingsSection(),
                SizedBox(height: size.height * 0.020),
                HardwareAndPeripheralsConfigurationSection(),
                SizedBox(height: size.height * 0.020),
                PaymentsPricingAndSecuritySection(),
                SizedBox(height: size.height * 0.020),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InventoryAndSerialNumberSettingsSection extends StatelessWidget {
  const InventoryAndSerialNumberSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSectionGroup(
      title: 'Inventory and Serial Number',
      icon: Iconsax.box_search,
      items: [
        SettingsTileItem(
          title: 'Serial Number Capture',
          subtitle:
              'Forces or allows scanning of unique serial numbers/IMEIs during sales and returns to track warranties.',
          icon: Iconsax.barcode,
          onTap: () {},
        ),
        SettingsTileItem(
          title: 'Stock Alerts',
          subtitle:
              'Sets low-stock thresholds for high-demand gadgets or accessories to trigger reorders automatically.',
          icon: Iconsax.notification,
          onTap: () {},
        ),
        SettingsTileItem(
          title: 'Product Matrix / Attributes',
          subtitle:
              'Configures variants like storage capacity, RAM, color, or carrier locking.',
          icon: Iconsax.category,
          onTap: () {},
        ),
      ],
    );
  }
}

class HardwareAndPeripheralsConfigurationSection extends StatelessWidget {
  const HardwareAndPeripheralsConfigurationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSectionGroup(
      title: 'Hardware & Peripherals',
      icon: Iconsax.cpu_setting,
      items: [
        SettingsTileItem(
          title: 'Barcode & Label Scanners',
          subtitle:
              'Adjusts scanner triggers, key capture delays, and pairing for specialized barcode or QR scanners.',
          icon: Iconsax.scan,
          onTap: () {},
        ),
        SettingsTileItem(
          title: 'Customer-Facing Display',
          subtitle:
              'Toggles second-screen totals, promotional images, or digital signature prompts.',
          icon: Iconsax.monitor,
          onTap: () {},
        ),
      ],
    );
  }
}

class PaymentsPricingAndSecuritySection extends StatelessWidget {
  const PaymentsPricingAndSecuritySection({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSectionGroup(
      title: 'Payments, Pricing & Security',
      icon: Iconsax.security_card,
      items: [
        SettingsTileItem(
          title: 'Payment Integrations',
          subtitle:
              'Connects credit/debit card terminals, gift cards, and multi-tender or split-payment options.',
          icon: Iconsax.card_pos,
          onTap: () {},
        ),
        SettingsTileItem(
          title: 'Tax Rules',
          subtitle:
              'Sets regional sales tax or VAT, including rules for eco-fees or electronic recycling levies.',
          icon: Iconsax.receipt_item,
          onTap: () =>
              Navigator.push(context, naviToAnotherPage(TaxRuleTemplatePage())),
        ),
        SettingsTileItem(
          title: 'Staff Permissions',
          subtitle:
              'Restricts high-level actions like manual price overrides, open-box discounts, or processing returns to manager PIN codes.',
          icon: Iconsax.user_tick,
          onTap: () {},
        ),
      ],
    );
  }
}

class SettingsSectionGroup extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> items;

  const SettingsSectionGroup({
    super.key,
    required this.title,
    required this.icon,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: surfaceCardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: white, width: 1),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: accentColor, size: 22),
              SizedBox(width: size.width * 0.01),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.aleo(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.012),
          Divider(color: primaryBorderColor, height: size.height * 0.001),
          SizedBox(height: size.height * 0.008),
          ...items,
        ],
      ),
    );
  }
}

class SettingsTileItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const SettingsTileItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Material(
        color: invisible,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          hoverColor: white.withOpacity(0.05),
          splashColor: accentColor.withOpacity(0.15),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: accentColor, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.aleo(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: GoogleFonts.aleo(
                          fontSize: 13,
                          color: lightGrey,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Iconsax.arrow_right_3, color: colorGrey, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
