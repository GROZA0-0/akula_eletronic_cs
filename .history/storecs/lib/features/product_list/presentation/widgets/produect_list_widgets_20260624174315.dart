import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:storecs/Core/config/call_controller.dart';
import 'package:storecs/Core/styles/Strings.dart';
import 'package:storecs/Core/styles/colors.dart';
import 'package:storecs/Core/styles/sizes.dart';
import 'package:storecs/Core/styles/text_styles.dart';

class ProduectListWidgets extends StatefulWidget {
  const ProduectListWidgets({super.key});

  @override
  State<ProduectListWidgets> createState() => _ProduectListWidgetsState();
}

class _ProduectListWidgetsState extends State<ProduectListWidgets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: invisible,
        iconTheme: IconThemeData(color: white),
        title: Text(ProductListPageText, style: textAppBar),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: white),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.symmetric(
              horizontal: size.width * 0.008,
              vertical: size.height * 0.010,
            ),
            width: double.infinity,
            // height: size.height / 2,
            child: Column(
              children: [
                InsertProductTextFieldTemplate(
                  text: 'Product Name',
                  icon: Icon(Iconsax.receipt_item, color: white),
                  controller: productListController.name,
                ),
                InsertProductTextFieldTemplate(
                  text: 'Brand Name',
                  icon: Icon(Iconsax.receipt_item, color: white),
                  controller: productListController.brand,
                ),
                SizedBox(
                  width: size.width / 4,
                  child: Obx(
                    () => DropdownButton<String>(
                      hint: Text(
                        "Gender",
                        style: GoogleFonts.aleo(
                          color: white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      value:
                          productListController.selectedCategory.value.isEmpty
                          ? null
                          : productListController.selectedCategory.value,
                      items: productListController.categories.map((
                        String value,
                      ) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: GoogleFonts.aleo(
                              color: white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        if (newValue != null) {
                          productListController.changeCategory(
                            newValue,
                          ); // Updates controller state
                        }
                      },
                    ),
                  ),
                ),
                Obx(
                  () => InkWell(
                    onTap: () => productListController.uploadProductPic(),
                    child: productListController.selectedFile.value != null
                        ? CircleAvatar(
                            radius: 60,
                            foregroundImage: FileImage(
                              productListController.selectedFile.value!,
                            ),
                          )
                        : Column(
                            children: [
                              Icon(
                                Iconsax.document_upload,
                                color: white,
                                size: 60,
                              ),

                              Text(
                                "Choose a profile picture.",
                                style: textAppBar,
                              ),
                            ],
                          ),
                  ),
                ),
                InsertProductTextFieldTemplate(
                  text: 'Barcode',
                  icon: Icon(Iconsax.receipt_item, color: white),
                  controller: productListController.barcode,
                ),
                InsertProductTextFieldTemplate(
                  text: 'Description',
                  icon: Icon(Iconsax.receipt_item, color: white),
                  controller: productListController.description,
                ),
                InsertProductTextFieldTemplate(
                  text: 'Product Price',
                  icon: Icon(Iconsax.receipt_item, color: white),
                  controller: productListController.price,
                ),
                InsertProductTextFieldTemplate(
                  text: 'Cost Price',
                  icon: Icon(Iconsax.receipt_item, color: white),
                  controller: productListController.costPrice,
                ),
                InsertProductTextFieldTemplate(
                  text: 'Quantities',
                  icon: Icon(Iconsax.receipt_item, color: white),
                  controller: productListController.stock,
                ),
                InkWell(
                  onTap: () => productListController.storeProductInfo(),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: size.width * 0.4,
                    height: size.height * 0.05,
                    child: Center(
                      child: Text(
                        "Create Product",
                        style: textStyleForButtons(24),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InsertProductTextFieldTemplate extends StatelessWidget {
  const InsertProductTextFieldTemplate({
    super.key,
    required this.text,
    required this.icon,
    required this.controller,
  });
  final String text;
  final Icon icon;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.020,
        vertical: size.height * 0.030,
      ),
      width: size.width / 1.2,
      height: size.height / 10,
      child: TextFormField(
        maxLength: 10,
        controller: controller,
        style: textBodiesStyle,
        decoration: InputDecoration(
          labelText: text,
          labelStyle: GoogleFonts.aleo(
            color: white,
            fontSize: 30,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: icon,
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
            borderSide: const BorderSide(color: greenColor, width: 2),
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
      ),
    );
  }
}
