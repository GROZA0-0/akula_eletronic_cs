import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:storecs/Core/config/call_controller.dart';
import 'package:storecs/Core/styles/Strings.dart';
import 'package:storecs/Core/styles/colors.dart';
import 'package:storecs/Core/styles/sizes.dart';
import 'package:storecs/Core/styles/text_styles.dart';
import 'package:storecs/features/product_list/presentation/state_management/product_list_bloc/product_list_bloc.dart';
import 'package:storecs/features/product_list/presentation/state_management/product_list_bloc/product_list_event_bloc.dart';
import 'package:storecs/features/product_list/presentation/state_management/product_list_bloc/product_list_state_bloc.dart';
import 'package:storecs/features/product_list/presentation/state_management/product_list_controller.dart';

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
            child: SwapSection(),
          ),
        ),
      ),
    );
  }
}

class SwapSection extends StatefulWidget {
  const SwapSection({super.key});

  @override
  State<SwapSection> createState() => _SwapSectionState();
}

class _SwapSectionState extends State<SwapSection> {
  String selected = 'Create Items';
  final List<String> productActions = ['Create Items', 'Categories'];
  final PageController pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width / 1.2,
      height: size.height / 0.75,
      child: Column(
        children: [
          SizedBox(
            width: size.width / 1.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: productActions.asMap().entries.map((entry) {
                final indx = entry.key;
                final action = entry.value;
                final isSelected = action == selected;
                return GestureDetector(
                  onTap: () => setState(() {
                    selected = action;
                    pageController.animateToPage(
                      indx,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }),
                  child: Container(
                    margin: EdgeInsets.only(
                      top: size.height * 0.01,
                      right: size.width * 0.008,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.016,
                      vertical: size.width * 0.005,
                    ),
                    decoration: BoxDecoration(
                      color: invisible,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? greenColor : white,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      action,
                      style: TextStyle(
                        color: isSelected ? greenColor : white,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          sizeBoxHeight(size.height * 0.02),
          Expanded(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                SingleChildScrollView(child: CreatingProductWidget()),
                CategoriesSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  final List<Map<String, dynamic>> categories = const [
    {
      'name': 'Phones',
      'icon': Icons.phone_android,
      'color': [blueColor, blueColor],
    },
    {
      'name': 'Tablates',
      'icon': Icons.tablet_android,
      'color': [greenColor, greenColor],
    },
    {
      'name': "Tv's & Monitors",
      'icon': Icons.tv,
      'color': [pink, pink],
    },
    {
      'name': 'Accessories',
      'icon': Icons.headphones,
      'color': [orange, white],
    },
    {
      'name': 'PS5',
      'icon': Icons.sports_esports,
      'color': [white, white],
    },
    {
      'name': "Pc's Components",
      'icon': Icons.computer,
      'color': [redColor, green, black, black],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductListBloc(repo: Get.find<ProductListController>())
            ..add(ProductListEventBlocLoading()),
      child: Builder(
        builder: (context) {
          return Container(
            margin: EdgeInsets.symmetric(
              horizontal: size.width * 0.016,
              vertical: size.width * 0.016,
            ),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final cat = categories[index];
                final color = (cat['color']);
                final bool isGrad = color is List;
                final List<Color> colors = isGrad
                    ? List<Color>.from(color)
                    : [color as Color];

                final firstColor = color[0];

                return InkWell(
                  onTap: () {
                    context.read<ProductListBloc>().add(
                      ProductListEventBlocLoaded(category: cat['name']),
                    );

                    showProductsModal(context, cat['name']);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: isGrad
                          ? LinearGradient(
                              colors: colors
                                  .map((e) => e.withOpacity(0.1))
                                  .toList(),
                            )
                          : null,
                      color: isGrad ? null : firstColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: firstColor),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(cat['icon'], color: firstColor, size: 40),
                        SizedBox(height: 8),
                        Text(cat['name'], style: textBodiesStyle),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

void showProductsModal(BuildContext context, String categoryName) {
  final blocInstance = context.read<ProductListBloc>();

  showModalBottomSheet(
    context: context,
    backgroundColor: grey.withOpacity(0.5),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
    ),
    builder: (modalContext) {
      return BlocProvider.value(
        value: blocInstance,
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: size.width * 0.016,
            vertical: size.width * 0.016,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(categoryName, style: textAppBar),
              const Divider(color: white),
              Expanded(
                child: BlocBuilder<ProductListBloc, ProductListStateBloc>(
                  builder: (context, state) {
                    if (state is ProductListStateBlocLoading) {
                      return Center(
                        child: LoadingAnimationWidget.beat(
                          color: white,
                          size: 55,
                        ),
                      );
                    } else if (state is ProductListStateBlocLoadedEmpty) {
                      return const Center(
                        child: Text(
                          "No products found in this category.",
                          style: TextStyle(color: white),
                        ),
                      );
                    } else if (state is ProductListStateBlocLoaded) {
                      return ListView.builder(
                        primary: true,
                        itemCount: state.entities.length,
                        itemBuilder: (context, idx) {
                          final product = state.entities[idx];
                          return ListTile(
                            title: Text(
                              product.name,
                              style: const TextStyle(color: white),
                            ),
                            subtitle: Text(
                              "${product.brand} - \$${product.price}",
                              style: const TextStyle(color: grey),
                            ),
                            leading: Image.memory(
                              repeat: ImageRepeat.repeat,
                              filterQuality: FilterQuality.medium,
                              width: size.width * 0.04,
                              height: size.width * 0.04,
                              base64Decode(product.img),
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      );
                    }

                    if (state is ProductListStateBlocError) {
                      return Center(
                        child: Text(
                          "Error: ${state.err}",
                          style: const TextStyle(color: redColor),
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class CreatingProductWidget extends StatelessWidget {
  const CreatingProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InsertProductTextFieldTemplate(
          lines: 1,
          text: 'Product Name',
          icon: Icon(Iconsax.receipt_item, color: white),
          controller: productListController.name,
        ),
        InsertProductTextFieldTemplate(
          lines: 1,
          text: 'Brand Name',
          icon: Icon(Iconsax.receipt_item, color: white),
          controller: productListController.brand,
        ),
        SizedBox(
          width: size.width / 4,
          child: Obx(
            () => DropdownButton<String>(
              dropdownColor: grey,
              hint: Text(
                "Category",
                style: GoogleFonts.aleo(
                  color: white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              value: productListController.selectedCategory.value.isEmpty
                  ? null
                  : productListController.selectedCategory.value,
              items: productListController.categories.map((String value) {
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
                      Icon(Iconsax.document_upload, color: white, size: 60),

                      Text("Choose a item picture.", style: textAppBar),
                    ],
                  ),
          ),
        ),
        InsertProductTextFieldTemplate(
          lines: 1,
          text: 'Barcode',
          icon: Icon(Iconsax.receipt_item, color: white),
          controller: productListController.barcode,
        ),
        InsertProductTextFieldTemplate(
          lines: 10,
          text: 'Description',
          icon: Icon(Iconsax.receipt_item, color: white),
          controller: productListController.description,
        ),
        InsertProductTextFieldTemplate(
          lines: 1,
          text: 'Product Price',
          icon: Icon(Iconsax.receipt_item, color: white),
          controller: productListController.price,
        ),
        InsertProductTextFieldTemplate(
          lines: 1,
          text: 'Cost Price',
          icon: Icon(Iconsax.receipt_item, color: white),
          controller: productListController.costPrice,
        ),
        InsertProductTextFieldTemplate(
          lines: 1,
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
              child: Text("Create Product", style: textStyleForButtons(24)),
            ),
          ),
        ),
      ],
    );
  }
}

class InsertProductTextFieldTemplate extends StatelessWidget {
  const InsertProductTextFieldTemplate({
    super.key,
    required this.text,
    required this.icon,
    required this.controller,
    required this.lines,
  });
  final String text;
  final Icon icon;
  final int lines;
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
        maxLines: lines,
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
