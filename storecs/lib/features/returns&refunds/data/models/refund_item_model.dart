class RefundItemModel {
  final String? id;
  final String pName;
  final int returnQuantity;
  final String refundPrice;

  RefundItemModel({
    required this.id,
    required this.pName,
    required this.returnQuantity,
    required this.refundPrice,
  });

  Map<String, dynamic> toJson() => {
    'pId': id,
    'pName': pName,
    'returnQuantity': returnQuantity,
    'refundPrice': refundPrice,
  };

  factory RefundItemModel.fromJson(Map<String, dynamic> map) {
    return RefundItemModel(
      id: map['_id']?.toString() ?? '',
      pName: map['pName']?.toString() ?? '',
      returnQuantity: map['returnQuantity'] ?? 0,
      refundPrice: map['refundPrice']?.toString() ?? '0.0',
    );
  }
}
