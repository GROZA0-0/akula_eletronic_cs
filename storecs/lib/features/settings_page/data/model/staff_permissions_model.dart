import 'package:storecs/features/settings_page/domain/entities/staff_permissions_entities.dart';

class StaffPermissionsModel {
  final bool pinRequired;
  final String pinHash;

  final Map<String, List<String>> hasAccess;

  StaffPermissionsModel({
    required this.pinRequired,
    required this.pinHash,

    required this.hasAccess,
  });

  static StaffPermissionsModel emptyStaffPermissionsModel() {
    return StaffPermissionsModel(
      pinRequired: false,
      pinHash: '',

      hasAccess: {},
    );
  }

  factory StaffPermissionsModel.fromJson(Map<String, dynamic> map) {
    return StaffPermissionsModel(
      pinRequired: map['pinRequired'] as bool? ?? false,
      pinHash: map['pinHash'] as String? ?? '',

      /* convert each entry using .map */
      hasAccess: map['hasAccess'] != null
          ? (map['hasAccess'] as Map<String, dynamic>).map(
              (key, value) => MapEntry(
                key,
                (value as List<dynamic>).map((e) => e.toString()).toList(),
              ),
            )
          : {},
    );
  }

  StaffPermissionsEntities toStaffPermissionsEntities() {
    return StaffPermissionsEntities(
      pinRequired: pinRequired,
      pinHash: pinHash,

      hasAccess: hasAccess,
    );
  }
}
