import 'package:storecs/features/product_list/domain/entities/product_list_entities.dart';

abstract class ProductListRepo {
  Future<InsertProductListEntities> toInsertProductListRepo(
    String name,
    String brand,
    String category,
    String image,
    String barcode,
    String description,
    String price,
    String costPrice,
    String stock,
  );
}
