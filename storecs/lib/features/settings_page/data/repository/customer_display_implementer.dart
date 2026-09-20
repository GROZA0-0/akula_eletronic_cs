import 'package:storecs/features/settings_page/data/data_source/data_source_repo/customer_display_data_source_repo.dart';
import 'package:storecs/features/settings_page/domain/entities/customer_display_entities.dart';
import 'package:storecs/features/settings_page/domain/repository/customer_display_repository.dart';

class CustomerDisplayImplementer implements CustomerDisplayRepository {
  final CustomerDisplayDataSourceRepo repo;
  CustomerDisplayImplementer({required this.repo});

  @override
  Future<CustomerDisplayEntities> getCustomerDisplayDataSourceRepo() async {
    try {
      final model = await repo.getCustomerDisplayDataSourceRepo();
      return model.toCustomerDisplayEntities();
    } catch (e) {
      print("any errors in get CustomerDisplayImplementer $e");
      throw e.toString();
    }
  }

  @override
  Future<void> storeCustomerDisplayRepository(
    Map<String, bool> customerDisplaySchema,
    Map<String, bool> showLiveTotals,
    Map<String, bool> showItemList,
    Map<String, bool> showPromotionalImages,
    Map<String, bool> requireDigitalSignature,
    Map<String, bool> showThankYouScreen,
    String idleScreenOptions,
  ) async {
    try {
      await repo.storeCustomerDisplayDataSourceRepo(
        customerDisplaySchema,
        showLiveTotals,
        showItemList,
        showPromotionalImages,
        requireDigitalSignature,
        showThankYouScreen,
        idleScreenOptions,
      );
    } catch (e) {
      print("any errors in store CustomerDisplayImplementer $e");
      throw e.toString();
    }
  }
}
