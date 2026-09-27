import 'package:storecs/features/dash_board/domain/entities/employee_info_entities.dart';

class Permissions {
  final EmployeeInfoEntities state; /* need initialize it  */
  final Map<String, List<String>> pageAccess;
  Permissions({required this.state, required this.pageAccess});
  /* use Map<String, List<String> to get each permissions with their levels*/
  bool hasAccess(String permissionKey) {
    final allLvls = pageAccess[permissionKey] ?? [];
    return allLvls.contains(state.level);
  }
}

class Allows {
  final Map<String, bool> carts;
  Allows({required this.carts});
  bool allowed(String allowKey) {
    final cart = carts[allowKey] ?? false;
    return cart;
  }
}

class StockAlertShow {
  final Map<String, bool> isAlertOn;
  StockAlertShow({required this.isAlertOn});
  bool allowed(String allowKey) {
    final alert = isAlertOn[allowKey] ?? false;
    return alert;
  }
}
