import 'package:storecs/features/settings_page/domain/entities/customer_display_entities.dart';

abstract class CustomerDisplayRepository {
  Future<void> storeCustomerDisplayRepository(
    Map<String, bool> customerDisplaySchema,
    Map<String, bool> showLiveTotals,
    Map<String, bool> showItemList,
    Map<String, bool> showPromotionalImages,
    Map<String, bool> requireDigitalSignature,
    Map<String, bool> showThankYouScreen,
    String idleScreenOptions,
  );
  Future<CustomerDisplayEntities> getCustomerDisplayDataSourceRepo();
}
