import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:storecs/Core/config/call_controller.dart';
import 'package:storecs/Core/styles/Strings.dart';
import 'package:storecs/Core/styles/animations.dart';
import 'package:storecs/Core/styles/colors.dart';
import 'package:storecs/Core/styles/sizes.dart';
import 'package:storecs/Core/styles/text_styles.dart';
import 'package:storecs/features/pos_page/domain/enitities/pos_entities.dart';
import 'package:storecs/features/pos_page/presentation/state_management/pos_bloc/pos_bloc.dart';
import 'package:storecs/features/pos_page/presentation/state_management/pos_bloc/pos_bloc_event.dart';
import 'package:storecs/features/pos_page/presentation/state_management/pos_bloc/pos_bloc_state.dart';

class PosWidgets extends StatefulWidget {
  const PosWidgets({super.key});

  @override
  State<PosWidgets> createState() => _PosWidgetsState();
}

class _PosWidgetsState extends State<PosWidgets> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PosBloc(posController, 'Phones')
            ..add(PosBlocEventLoaded(category: 'Phones')),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: invisible,
          iconTheme: IconThemeData(color: white),
          title: Text(POSPage, style: textAppBar),
          actions: [
            Container(
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
          ],
        ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            margin: screenSize,
            child: SingleChildScrollView(
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
                            CategoryTabs(),
                            Expanded(
                              child:
                                  ProductsGrid() /* ProductCard(entities: ,) */,
                            ),
                          ],
                        ),
                      ),
                    ),
                    sizeBoxWidth(size.width * 0.02),

                    CartSection(),
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
  const CartSection({super.key});

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
            Column(
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
                      IconButton(
                        icon: DrawerIconAnimation(
                          iconData: Iconsax.refresh1,
                          voidCallback: () {},
                        ),
                        color: white,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: size.width / 3.1,
                  child: Divider(color: white),
                ),
              ],
            ),
            /* List of items in order */
            //
            //
            //
            /* Paying ofr order */
            Container(
              width: size.width / 3.1,
              height: size.height / 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: white, width: 3),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: size.width,
                    margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Order Price :-", style: textBodiesStyle),
                        sizeBoxHeight(size.height * 0.02),
                        Text("Taxs :-", style: textBodiesStyle),
                        sizeBoxHeight(size.height * 0.02),
                        Text("Total Price :-", style: textBodiesStyle),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width / 3.5,
                    height: size.height / 14,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: white, width: 2),
                    ),
                    child: Center(
                      child: Text("Confirm Processed", style: textBodiesStyle),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryTabs extends StatefulWidget {
  const CategoryTabs({super.key});

  @override
  State<CategoryTabs> createState() => _CategoryTabsState();
}

class _CategoryTabsState extends State<CategoryTabs> {
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
              children: categories.map((cat) {
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
      onTap: () {},
      child: Container(
        height: size.height / 2,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            entities.image.isNotEmpty
                ? Flexible(
                    flex: 3,
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: white,
                      ),
                      width: size.width / 2.5,
                      height: size.height / 2.5,
                      child: Image.memory(
                        base64Decode(entities.image),
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                : CircleAvatar(
                    radius: 35,
                    backgroundColor: white.withOpacity(0.1),
                    child: Icon(Icons.phone_android, color: white, size: 30),
                  ),

            sizeBoxHeight(size.height * 0.008),

            Flexible(
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
                      entities.name,
                      textAlign: TextAlign.center,
                      style: textBodiesStyle,
                    ),

                    sizeBoxHeight(size.height * 0.002),

                    Text(
                      '${entities.price.toString()} JOD',
                      style: textBodiesStyle,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
