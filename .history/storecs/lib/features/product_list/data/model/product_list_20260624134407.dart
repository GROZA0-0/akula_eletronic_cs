class ProductList {
  final String id;
  final String name;
  final String brand;
  final String category;
  final String image;
  final String barcode;
  final String description;
  final double price;
  final double costPrice;
  final double stock;
  ProductList({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.image,
    required this.barcode,
    required this.description,
    required this.price,
    required this.costPrice,
    required this.stock,
  });


  Map<String,dynamic> toJson(){
    return{
      "pId":id,
      "pName":name,
      "pBrand":brand,
      "pCategory":category,
      "pImage":image,
      "pBarcode":barcode,
      "pDescription":description,
      "pPrice":0,
      "pCostPrice":0,
      "pStock":0
    }
  }
}
