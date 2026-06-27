import 'package:storecs/features/product_list/domain/entities/product_list_entities.dart';

abstract class ProductListRepo {
  Future<InsertProductListEntities> toInsertProductListRepo(
    String id,
    String name,
    String brand,
    String category,
    String image,
    String barcode,
    String description,
    double price,
    double costPrice,
    double stock,
  );
}
