class RefundItemModel {
  final String? id;
  final String pName;
  final String pCategory;
  final int returnQuantity;
  final double refundPrice;

  RefundItemModel({
    required this.id,
    required this.pName,
    required this.pCategory,
    required this.returnQuantity,
    required this.refundPrice,
  });

  Map<String, dynamic> toJson() => {
    '_id': id,
    'pName': pName,
    'pCategory': pCategory,
    'returnQuantity': returnQuantity,
    'refundPrice': refundPrice,
  };

  factory RefundItemModel.fromJson(Map<String, dynamic> map) {
    return RefundItemModel(
      id: map['_id']?.toString() ?? '',
      pName: map['pName']?.toString() ?? '',
      pCategory: map['pCategory']?.toString() ?? '',
      returnQuantity: map['returnQuantity'] ?? 0.0,
      refundPrice: (map['price'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
