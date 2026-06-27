import 'package:flutter/widgets.dart';
import 'package:storecs/features/product_list/presentation/pages/product_list.dart';

class ProduectListWidgets extends StatefulWidget {
  const ProduectListWidgets({super.key});

  @override
  State<ProduectListWidgets> createState() => _ProduectListWidgetsState();
}

class _ProduectListWidgetsState extends State<ProduectListWidgets> {
  @override
  Widget build(BuildContext context) {
    return ProductListPage();
  }
}
