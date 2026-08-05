import 'dart:async';
import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:storecs/Core/config/call_controller.dart';
import 'package:storecs/Core/styles/Strings.dart';
import 'package:storecs/Core/styles/alerts.dart';
import 'package:storecs/Core/styles/animations.dart';
import 'package:storecs/Core/styles/colors.dart';
import 'package:storecs/Core/styles/sizes.dart';
import 'package:storecs/Core/styles/text_styles.dart';
import 'package:storecs/features/pos_page/domain/enitities/cart_entities.dart';
import 'package:storecs/features/pos_page/domain/enitities/list_of_items_purchased_entities.dart';
import 'package:storecs/features/pos_page/domain/enitities/pos_entities.dart';

import 'package:storecs/features/pos_page/presentation/state_management/pos_bloc/pos_bloc.dart';
import 'package:storecs/features/pos_page/presentation/state_management/pos_bloc/pos_bloc_event.dart';
import 'package:storecs/features/pos_page/presentation/state_management/pos_bloc/pos_bloc_state.dart';

import 'package:storecs/main.dart';

class PosWidgets extends StatefulWidget {
  const PosWidgets({super.key});

  @override
  State<PosWidgets> createState() => _PosWidgetsState();
}

class _PosWidgetsState extends State<PosWidgets> {
  final List<String> categories = [
    "Phones",
    "Tablates",
    "Tv's & Monitors",
    "Accessories",
    "PS5",
    "Pc's Components",
  ];
  @override
  Widget build(BuildContext context) {
    final bool passMouse = false;
    return BlocProvider(
      create: (context) =>
          PosBloc(posController, 'Phones')
            ..add(PosBlocEventLoaded(category: 'Phones')),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: invisible,
          iconTheme: IconThemeData(color: white),
          title: FadeInLeft(child: Text(POSPage, style: textAppBar)),
          actions: [
            FadeInRight(
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: size.width * 0.13,
                  vertical: size.width * 0.0011,
                ),
                width: size.width / 3,
                child: CupertinoSearchTextField(
                  cursorColor: white,
                  itemColor: white,
                  placeholder: 'Search Product',
                  placeholderStyle: textBodiesStyle,
                  style: textBodiesStyle,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: white),
                  ),
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: FadeInUp(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              margin: screenSize,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: white, width: 3),
                  borderRadius: BorderRadius.circular(10),
                ),

                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.032,
                  horizontal: size.width * 0.008,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: size.height * 1.250,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CategoryTabs(categories: categories),
                            Expanded(child: ProductsGrid()),
                          ],
                        ),
                      ),
                    ),
                    sizeBoxWidth(size.width * 0.02),

                    CartSection(passMouse: passMouse, categories: categories),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CartSection extends StatelessWidget {
  final List<String> categories;
  final bool passMouse;
  const CartSection({
    super.key,
    required this.passMouse,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width / 3,
      height: size.height * 1.250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: white),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customerOrder(),

            emptyCardSection(),
            orderPriceDetails(context),
          ],
        ),
      ),
    );
  }

  Widget orderPriceDetails(BuildContext context) {
    return Container(
      width: size.width / 3.1,
      height: size.height / 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: white, width: 3),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Obx(
            () => Container(
              width: size.width,
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PriceRow(
                    label: 'Order Price :-',
                    value: '${cartController.subTotal.toStringAsFixed(2)} JOD',
                  ),

                  sizeBoxHeight(size.height * 0.02),
                  PriceRow(
                    label: 'Tax (16%) :-',
                    value: '${cartController.taxAmount.toStringAsFixed(2)} JOD',
                  ),

                  sizeBoxHeight(size.height * 0.02),
                  PriceRow(
                    label: 'Total Price :-',
                    value: '${cartController.total.toStringAsFixed(2)} JOD',
                  ),
                ],
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardButtons(
                callback: () async => await cartController.purchase(),
                height: size.height / 14,
                width: size.width / 5.5,
                text: "Confirm Processed",
              ),
              CardButtons(
                callback: () => _onShowReceiptPressed(context),
                height: size.height / 14,
                width: size.width / 9,
                text: "Show Receipt",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _onShowReceiptPressed(BuildContext context) async {
    final alerts = Alerts(messengerKey);
    final receipt = cartController.purchasedReceipt;
    if (receipt == null) {
      alerts.ifErrors(
        "No completed transaction found. Please make a purchase first.",
      );
      return;
    }
    // final orderId = receipt.orderId;
    // print("Purchased Receipt Items Count: ${receipt.items.length}");
    _showReceiptModal(context, receipt);
    // print("Displaying local receipt : $orderId");
  }

  void _showReceiptModal(
    BuildContext context,
    ListOfItemsPurchasedEntities? receipt,
  ) {
    final items = receipt?.items ?? [];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: grey.withOpacity(0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      builder: (modalContext) {
        if (items.isEmpty) {
          return Container(
            height: size.height / 2,
            width: size.width / 2.5,

            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.receipt_long_outlined, size: 48, color: white),
                const SizedBox(height: 12),
                Text("There is no receipt", style: textBodiesStyle),
                const SizedBox(height: 8),
                Text(
                  "No completed transaction found. Please make a purchase first.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.aleo(
                    color: white,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ],
            ),
          );
        } else if (items.isNotEmpty) {
          return Container(
            height: size.height / 2,
            width: size.width / 2.5,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Receipt: ${receipt?.orderId}", style: textBodiesStyle),
                const Divider(color: csGrey, height: 20),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (ctx, i) {
                      final item = items[i];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.004,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${item.name} x${item.quantity}',
                              style: const TextStyle(color: white),
                            ),
                            Text(
                              "${item.price} JOD",
                              style: const TextStyle(color: white),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Divider(color: white, height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: white,
                      ),
                    ),
                    Text(
                      "${receipt?.totalPrice.toStringAsFixed(2)} JOD",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: green,
                      ),
                    ),
                  ],
                ),
                sizeBoxHeight(size.height * 0.04),
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => printReceiptToConsole(receipt!),
                  child: Container(
                    margin: EdgeInsets.only(top: size.height * 0.15),
                    width: size.width / 4,
                    height: size.height * 0.07,
                    decoration: BoxDecoration(
                      border: Border.all(color: white),
                      borderRadius: BorderRadius.circular(10),
                      color: greenColor,
                    ),
                    child: Center(
                      child: Text(
                        'Print Receipt',
                        style: GoogleFonts.aleo(
                          color: white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  void printReceiptToConsole(ListOfItemsPurchasedEntities receipt) {
    print("========================================");
    print("         RECEIPT: ${receipt.orderId}");
    print("========================================");
    // Column Headers: 22 chars for ITEM, 4 chars for QTY, 14 chars for PRICE (Total: 40)
    print("${'ITEM'.padRight(22)} ${'QTY'.padRight(4)} ${'PRICE'.padLeft(12)}");
    print("----------------------------------------");

    for (final item in receipt.items) {
      // Truncate long names to 20 chars max to fit within padRight(22)
      String name = item.name.length > 20
          ? "${item.name.substring(0, 17)}..."
          : item.name;

      String formattedName = name.padRight(22);
      String formattedQty = "x${item.quantity.value}".padRight(4);
      String priceStr = "${item.price.toStringAsFixed(2)} JOD".padLeft(12);

      print("$formattedName $formattedQty $priceStr");
    }

    print("----------------------------------------");
    String formattedTotalLabel = "TOTAL:".padRight(27);
    String formattedTotalPrice = "${receipt.totalPrice.toStringAsFixed(2)} JOD"
        .padLeft(12);

    print("$formattedTotalLabel $formattedTotalPrice");
    print("========================================");
  }

  Widget emptyCardSection() {
    return Expanded(
      child: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart_outlined, color: white, size: 50),
                SizedBox(height: 8),
                Text('Cart is empty', style: textBodiesStyle),
              ],
            ),
          );
        } else {
          return ListView.builder(
            itemCount: cartController.cartItems.length,
            itemBuilder: (context, index) {
              final item = cartController.cartItems[index];
              return CartItemWidget(item: item);
            },
          );
        }
      }),
    );
  }

  Widget customerOrder() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: size.width * 0.009,
            vertical: size.height * 0.01,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /* customer Order */
              Text("Customer Order", style: textBodiesStyle),
              Obx(
                () => Text(
                  '${cartController.totalItems} items',
                  style: GoogleFonts.aleo(
                    color: greenColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              DrawerIconAnimation(
                iconData: Iconsax.refresh1,
                voidCallback: () => cartController.clearCart(),
              ),
            ],
          ),
        ),
        SizedBox(
          width: size.width / 3.1,
          child: Divider(color: white),
        ),
      ],
    );
  }
}

class CardButtons extends StatefulWidget {
  final VoidCallback callback;
  final double width, height;
  final String text;

  const CardButtons({
    super.key,
    required this.callback,
    required this.height,
    required this.width,
    required this.text,
  });

  @override
  State<CardButtons> createState() => _CardButtonState();
}

class _CardButtonState extends State<CardButtons> {
  bool passMouse = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
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
            border: Border.all(color: passMouse ? green : white, width: 2),
          ),
          child: Center(child: Text(widget.text, style: textBodiesStyle)),
        ),
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final CartEntities item;

  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // print('item with category ${item.category}');
    return FadeInLeft(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.008,
          vertical: size.height * 0.006,
        ),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: orange),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: item.image.isNotEmpty
                  ? Image.memory(
                      base64Decode(item.image),
                      width: 45,
                      height: 45,
                      fit: BoxFit.contain,
                    )
                  : Icon(Icons.phone_android, color: white, size: 45),
            ),

            sizeBoxWidth(size.width * 0.005),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: invisible,
                    child: Text(
                      "${item.brand}-${item.name}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textBodiesStyle,
                    ),
                  ),
                  Text(
                    item.category,
                    style: TextStyle(color: csGrey, fontSize: 10),
                  ),
                  Text(
                    '${item.price} JOD',
                    style: TextStyle(color: greenColor, fontSize: 12),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                GestureDetector(
                  onTap: () => cartController.decreaseQty(item.id),
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: white),
                    ),
                    child: Icon(Icons.remove, color: white, size: 14),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.008),
                  child: Text("${item.quantity}", style: textBodiesStyle),
                ),

                GestureDetector(
                  onTap: () => cartController.increaseQty(item.id),
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: white),
                    ),
                    child: Icon(Icons.add, color: white, size: 14),
                  ),
                ),
              ],
            ),

            sizeBoxWidth(size.width * 0.004),

            GestureDetector(
              onTap: () => cartController.removeItem(item.id),
              child: Icon(Icons.close, color: redColor, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}

class PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  const PriceRow({
    super.key,
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: white,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: isBold ? greenColor : white,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class CategoryTabs extends StatefulWidget {
  final List<String> categories;
  const CategoryTabs({super.key, required this.categories});

  @override
  State<CategoryTabs> createState() => _CategoryTabsState();
}

class _CategoryTabsState extends State<CategoryTabs> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PosBloc, PosBlocState>(
      builder: (context, state) {
        final String selected = state is PosBlocStateLoaded
            ? state.category
            : 'Phones';
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: widget.categories.map((cat) {
                final isSelected = cat == selected;
                return GestureDetector(
                  onTap: () => context.read<PosBloc>().add(
                    PosBlocEventChangeCategory(category: cat),
                  ),

                  child: Container(
                    margin: EdgeInsets.only(right: size.width * 0.008),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? greenColor : white,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      cat,
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
        );
      },
    );
  }
}

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PosBloc, PosBlocState>(
      builder: (context, state) {
        if (state is PosBlocStateLoading) {
          return loadingStateBodies();
        } else if (state is PosBlocStateEmpty) {
          return SizedBox(
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Positioned(
                      top: size.height * 0.01,
                      left: size.width * 0.0045,
                      child: Icon(size: 15, FontAwesomeIcons.x, color: white),
                    ),
                    Icon(size: 30, Iconsax.search_normal_1, color: white),
                  ],
                ),
                Text(
                  "No products found in this category.",
                  style: textBodiesStyle,
                ),
              ],
            ),
          );
        } else if (state is PosBlocStateLoaded) {
          return GridView.builder(
            padding: EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // 4 columns
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.68,
            ),
            itemCount: state.entities.length,
            itemBuilder: (context, index) {
              final product = state.entities[index];
              return ProductCard(entities: product);
            },
          );
        }
        return Container();
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final PosEntities entities;
  const ProductCard({super.key, required this.entities});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          entities.stock > 0 ? cartController.addToCart(entities) : null,
      child: Container(
        height: size.height / 2,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            entities.image.isNotEmpty ? fetchItemImage() : itemHasNoImage(),

            sizeBoxHeight(size.height * 0.008),

            itemDetails(),
          ],
        ),
      ),
    );
  }

  Widget itemDetails() {
    return Flexible(
      flex: 1,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.004,
          vertical: size.height * 0.004,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              maxLines: 1,
              "${entities.brand} ${entities.name}",
              textAlign: TextAlign.center,
              style: textBodiesStyle,
            ),

            sizeBoxHeight(size.height * 0.002),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    '${entities.price.toString()} JOD',
                    style: textBodiesStyle,
                    maxLines: 1,
                  ),
                ),
                sizeBoxWidth(size.width * 0.003),
                Flexible(
                  child: Text(
                    entities.stock > 0 ? 'In Stock' : 'Out of stock',
                    style: GoogleFonts.aleo(
                      color: entities.stock > 0 ? greenColor : redColor,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget itemHasNoImage() {
    return CircleAvatar(
      radius: 35,
      backgroundColor: white.withOpacity(0.1),
      child: Icon(Icons.phone_android, color: white, size: 30),
    );
  }

  Widget fetchItemImage() {
    return Flexible(
      flex: 3,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: white,
        ),
        width: size.width / 2.5,
        height: size.height / 2.5,
        child: Image.memory(base64Decode(entities.image), fit: BoxFit.contain),
      ),
    );
  }
}
