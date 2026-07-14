import 'package:storecs/features/dash_board/domain/entities/employee_info_entities.dart';

class Permissions {
  final EmployeeInfoEntities state; /* need initialize it  */
  Permissions({required this.state});
  /* use get to make variable accept the state to initialize it  */
  bool get cashierAccess => state.level == 'Cashier';
  bool get salesAccess => state.level == 'Sales';
  bool get supervisorAccess => state.level == 'Supervisor';
  bool get qaAccess => state.level == 'Q/A';
  bool get hrAccess => state.level == 'HR';
  bool get itAccess => state.level == 'IT';
  bool get accAccess => state.level == 'Accountant';
  bool get whAccess => state.level == 'Warehouse Keeper';
  bool empPagesAccCondition() {
    return cashierAccess ||
        salesAccess ||
        supervisorAccess ||
        qaAccess ||
        accAccess ||
        whAccess;
  }

  bool settingsPageAccCondition() {
    return cashierAccess ||
        salesAccess ||
        whAccess ||
        supervisorAccess ||
        qaAccess;
  }

  bool orderActionsAccCondition() {
    return salesAccess || cashierAccess || qaAccess | accAccess;
  }
}
