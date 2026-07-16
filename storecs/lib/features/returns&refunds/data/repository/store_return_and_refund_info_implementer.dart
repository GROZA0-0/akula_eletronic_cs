import 'package:storecs/features/returns&refunds/data/data_source/get_order_details_data_source_repository/store_return_and_refund_info_data_source_repository.dart';
import 'package:storecs/features/returns&refunds/data/models/refund_item_model.dart';
import 'package:storecs/features/returns&refunds/domain/entities/store_the_refund_info_entities.dart';
import 'package:storecs/features/returns&refunds/domain/repository/store_return_and_refund_info_repository.dart';

class StoreReturnAndRefundInfoImplementer
    implements StoreReturnAndRefundInfoRepository {
  final StoreReturnAndRefundInfoDataSourceRepository repository;
  StoreReturnAndRefundInfoImplementer({required this.repository});

  @override
  Future<StoreTheRefundInfoEntities> storeTheRefundInfoRepo(
    String orderId,
    bool restoreInventory,
    String refundReason,
    double totalRefundAmount,
    List<RefundItemModel> items,
  ) async {
    try {
      final model = await repository.toStoreTheRefundInfoRepo(
        orderId,
        restoreInventory,
        refundReason,
        totalRefundAmount,
        items,
      );
      return model.toStoreTheRefundInfoEntities();
    } catch (e) {
      print("any errors in StoreReturnAndRefundInfoImplementer $e");
      throw e.toString();
    }
  }
}
