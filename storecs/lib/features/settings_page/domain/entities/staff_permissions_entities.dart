import 'package:equatable/equatable.dart';

class StaffPermissionsEntities extends Equatable {
  final bool pinRequired;
  final String pinHash;

  final Map<String, List<String>> hasAccess;

  const StaffPermissionsEntities({
    required this.pinRequired,
    required this.pinHash,

    required this.hasAccess,
  });

  @override
  List<Object?> get props => [pinRequired, pinHash, hasAccess];
}
