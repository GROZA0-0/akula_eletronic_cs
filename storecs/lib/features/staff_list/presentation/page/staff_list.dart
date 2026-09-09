import 'package:flutter/widgets.dart';
import 'package:storecs/features/dash_board/domain/entities/employee_info_entities.dart';
import 'package:storecs/features/staff_list/presentation/widget/staff_list_widgets.dart';

class StaffListPage extends StatelessWidget {
  final EmployeeInfoEntities entities;
  const StaffListPage({super.key, required this.entities});

  @override
  Widget build(BuildContext context) {
    return StaffListWidgets(entities: entities);
  }
}
