import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:storecs/Core/styles/Strings.dart';
import 'package:storecs/Core/styles/colors.dart';
import 'package:storecs/Core/styles/sizes.dart';
import 'package:storecs/Core/styles/text_styles.dart';

class PosWidgets extends StatefulWidget {
  const PosWidgets({super.key});

  @override
  State<PosWidgets> createState() => _PosWidgetsState();
}

class _PosWidgetsState extends State<PosWidgets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            // color: yellow,
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
          height: double.infinity /* / 0.90, */,
          margin: screenSize,
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: white),
                borderRadius: BorderRadius.circular(10),
              ),
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: size.height * 0.030,
                horizontal: size.width * 0.008,
              ),
              child: Row(
                children: [
                  /* CategoryTabs(),ProductsGrid() */
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: size.height / 1.1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [CategoryTabs(), ProductCard()],
                      ),
                    ),
                  ),
                  sizeBoxWidth(size.width * 0.02),
                  /* Cart section */
                  CartSection(),
                ],
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
      height: size.height * 0.9,
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
                        icon: Icon(Icons.refresh),
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

            /* Paying ofr order */
            Container(
              width: size.width / 3.1,
              height: size.height / 5,
              decoration: BoxDecoration(
                color: redColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: white),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Order Price :-"),
                      Text("Taxs :-"),
                      Text("Total Price :-"),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: yellow,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: white),
                    ),
                    child: Text("Confirm Processed", style: textBodiesStyle),
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
  String selected = 'Lunch';
  final List<String> categories = [
    "Phones",
    "Tablates",
    "Tv's & Monitors",
    "Accessories ",
    "PS5",
    "Pc's Components",
  ];

  @override
  Widget build(BuildContext context) {
    bool isHovered = false;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: categories.map((cat) {
          final isSelected = cat == selected;
          return Padding(
            padding: EdgeInsets.only(right: 8),
            child: MouseRegion(
              onEnter: (event) => setState(() => selected = cat),
              onHover: (event) => isHovered == true,
              onExit: (event) => isHovered == false,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: isSelected ? greenColor : white),
                ),
                child: Text(
                  cat,
                  style: TextStyle(
                    color: isSelected || isHovered ? greenColor : white,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // 4 columns
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemCount: 12,
        itemBuilder: (context, index) => ProductCard(),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: size.height / 2,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Text("No items in the basement", style: textBodiesStyle),
        ) /* Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ✅ Round product image
            CircleAvatar(
              radius: 45,
              backgroundImage: NetworkImage('your_image_url'),
              backgroundColor: Colors.grey[100],
            ),

            SizedBox(height: 8),

            // ✅ Product name
            Text(
              'iPhone 15 Pro',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            ),

            SizedBox(height: 4),

            // ✅ Price
            Text(
              '\$999.00',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ), */,
      ),
    );
  }
}
