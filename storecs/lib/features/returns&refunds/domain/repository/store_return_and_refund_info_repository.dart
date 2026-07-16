import 'package:storecs/features/returns&refunds/data/models/refund_item_model.dart';
import 'package:storecs/features/returns&refunds/domain/entities/store_the_refund_info_entities.dart';

abstract class StoreReturnAndRefundInfoRepository {
  Future<StoreTheRefundInfoEntities> storeTheRefundInfoRepo(
    String orderId,
    bool restoreInventory,
    String refundReason,
    double totalRefundAmount,
    List<RefundItemModel> items,
  );
}
