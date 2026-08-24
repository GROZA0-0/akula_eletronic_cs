import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:storecs/Core/config/call_controller.dart';
import 'package:storecs/Core/styles/colors.dart';
import 'package:storecs/Core/styles/text_styles.dart';

class TaxRuleTemplateWidget extends StatefulWidget {
  const TaxRuleTemplateWidget({super.key});

  @override
  State<TaxRuleTemplateWidget> createState() => _TaxRuleTemplatePageState();
}

class _TaxRuleTemplatePageState extends State<TaxRuleTemplateWidget> {
  @override
  void dispose() {
    taxRulesController.taxNameController.dispose();
    taxRulesController.taxRateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: invisible,
        elevation: 0,
        title: FadeInLeft(child: Text('Tax Rules Settings', style: textAppBar)),
        iconTheme: const IconThemeData(color: white),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton.icon(
              onPressed: () => taxRulesController.saveTaxRule(),
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Iconsax.save_2, size: 18, color: white),
              label: Text('Save Rule', style: textBodiesStyle),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: FadeInUp(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTemplateHeader(),
              const SizedBox(height: 24),
              _buildConfigurationCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTemplateHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: accentColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accentColor.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Iconsax.info_circle, color: accentColor, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Template 1: Single Standard Rate',
                  style: GoogleFonts.aleo(
                    color: white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Used for simple retail when one flat tax rate applies to nearly everything sold. '
                  'Set as the store-wide default tax rule.',
                  style: GoogleFonts.aleo(
                    color: lightGrey,
                    height: 1.4,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfigurationCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: surfaceCardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: primaryBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rule Configuration',
            style: GoogleFonts.aleo(
              color: white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(color: primaryBorderColor, height: 32),

          // Row 1: Name and Rate
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildTextField(
                  label: 'Tax Name',
                  controller: taxRulesController.taxNameController,
                  icon: Iconsax.tag,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 1,
                child: _buildTextField(
                  label: 'Rate (%)',
                  controller: taxRulesController.taxRateController,
                  icon: Iconsax.percentage_square,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Row 2: Basis and Rounding
          Row(
            children: [
              Expanded(
                child: _buildDropdownField(
                  label: 'Tax Basis',
                  value: taxRulesController.taxBasis,
                  items: [
                    'Tax-Exclusive (Added at checkout)',
                    'Tax-Inclusive (Included in price)',
                  ],
                  onChanged: (val) =>
                      setState(() => taxRulesController.taxBasis = val!),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDropdownField(
                  label: 'Rounding Rule',
                  value: taxRulesController.roundingRule,
                  items: [
                    'Round to nearest 0.01',
                    'Round up to nearest 0.05',
                    'Always round up',
                  ],
                  onChanged: (val) =>
                      setState(() => taxRulesController.roundingRule = val!),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Row 3: Application Scope
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: steelColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: primaryBorderColor),
            ),
            child: SwitchListTile(
              title: const Text(
                'Apply to All Products',
                style: TextStyle(color: white),
              ),
              subtitle: const Text(
                'Default rule applied at checkout unless item is flagged exempt.',
                style: TextStyle(color: colorGrey, fontSize: 12),
              ),
              activeColor: accentColor,
              value: taxRulesController.applyToAllProducts,
              onChanged: (bool value) {
                setState(() {
                  taxRulesController.applyToAllProducts = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: colorGrey, fontSize: 13)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(color: white),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: colorGrey, size: 20),
            filled: true,
            fillColor: Colors.black26,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: primaryBorderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: primaryBorderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: accentColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: colorGrey, fontSize: 13)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: primaryBorderColor),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              dropdownColor: surfaceCardColor,
              style: const TextStyle(color: white),
              icon: const Icon(Iconsax.arrow_down_1, color: colorGrey),
              items: items.map((String item) {
                return DropdownMenuItem<String>(value: item, child: Text(item));
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
