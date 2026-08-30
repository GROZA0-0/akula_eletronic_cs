import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storecs/Core/config/call_controller.dart';
import 'package:storecs/Core/styles/animations.dart';
import 'package:storecs/Core/styles/colors.dart';
import 'package:storecs/Core/styles/sizes.dart';
import 'package:storecs/Core/styles/text_styles.dart';
import 'package:storecs/features/settings_page/presentation/state_management/product_matrix_bloc/product_matrix_bloc.dart';
import 'package:storecs/features/settings_page/presentation/state_management/product_matrix_bloc/product_matrix_bloc_event.dart';
import 'package:storecs/features/settings_page/presentation/state_management/product_matrix_bloc/product_matrix_bloc_state.dart';
import 'package:storecs/features/settings_page/presentation/state_management/product_matrix_controller.dart';

class ProductMatrixWidget extends StatefulWidget {
  const ProductMatrixWidget({super.key});

  @override
  State<ProductMatrixWidget> createState() => _ProductMatrixWidgetState();
}

class _ProductMatrixWidgetState extends State<ProductMatrixWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: invisible,
        iconTheme: IconThemeData(color: white),
        title: FadeInLeft(
          child: Text('Products Attributes', style: textAppBar),
        ),
      ),
      body: FadeInUp(
        child: SafeArea(
          child: SingleChildScrollView(
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => ProductMatrixBloc(
                    controller: sl<ProductMatrixController>(),
                  )..add(ProductMatrixBlocEventLoading()),
                ),
              ],
              child: BlocBuilder<ProductMatrixBloc, ProductMatrixBlocState>(
                builder: (context, state) {
                  if (state is ProductMatrixBlocStateLoading) {
                    return loadingStateBlocMethod(size);
                  } else if (state is ProductMatrixBlocStateError) {
                    return Text(state.err, style: textBodiesStyle2);
                  } else if (state is ProductMatrixBlocStateLoaded) {
                    final group = productMatrixController.categoriesGrouped(
                      state.entities,
                    );
                    final categories = group.keys.toList();
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final section = categories[index];
                        final item = group[section]!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsGeometry.only(
                                left: size.width * 0.01,
                              ),
                              child: Text(
                                section,
                                style: GoogleFonts.aleo(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: white,
                                ),
                              ),
                            ),

                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: white),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              margin: EdgeInsets.symmetric(
                                horizontal: size.width * 0.02,
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: item.length,
                                itemBuilder: (context, index) {
                                  final product = item[index];
                                  return ListTile(
                                    leading: Image.memory(
                                      repeat: ImageRepeat.repeat,
                                      filterQuality: FilterQuality.medium,
                                      width: size.width * 0.04,
                                      height: size.width * 0.04,
                                      base64Decode(product.image),
                                      fit: BoxFit.cover,
                                    ),
                                    title: Text(
                                      "${product.brand} ${product.name}",
                                      style: GoogleFonts.aleo(
                                        fontSize: 21,
                                        fontWeight: FontWeight.bold,
                                        color: white,
                                      ),
                                    ),
                                    subtitle: Text(
                                      product.description,
                                      style: GoogleFonts.aleo(
                                        fontWeight: FontWeight.bold,
                                        color: white,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
