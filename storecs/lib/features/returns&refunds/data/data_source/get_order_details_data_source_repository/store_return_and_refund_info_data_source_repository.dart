import 'package:storecs/features/returns&refunds/data/models/refund_item_model.dart';
import 'package:storecs/features/returns&refunds/data/models/store_the_refund_info_model.dart';

abstract class StoreReturnAndRefundInfoDataSourceRepository {
  Future<StoreTheRefundInfoModel> toStoreTheRefundInfoRepo(
    String orderId,
    bool restoreInventory,
    String refundReason,
    double totalRefundAmount,
    List<RefundItemModel> item,
  );
}
