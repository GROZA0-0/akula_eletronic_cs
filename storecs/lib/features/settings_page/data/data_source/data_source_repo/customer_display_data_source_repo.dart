import 'package:storecs/features/settings_page/data/model/customer_display_model.dart';

abstract class CustomerDisplayDataSourceRepo {
  Future<void> storeCustomerDisplayDataSourceRepo(
    Map<String, bool> customerDisplaySchema,
    Map<String, bool> showLiveTotals,
    Map<String, bool> showItemList,
    Map<String, bool> showPromotionalImages,
    Map<String, bool> requireDigitalSignature,
    Map<String, bool> showThankYouScreen,
    String idleScreenOptions,
  );
  Future<CustomerDisplayModel> getCustomerDisplayDataSourceRepo();
}
