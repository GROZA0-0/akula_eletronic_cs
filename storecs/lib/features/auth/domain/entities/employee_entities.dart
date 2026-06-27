import 'package:equatable/equatable.dart';

class EmployeeSignInEntities extends Equatable {
  final String id;
  final String email;

  const EmployeeSignInEntities({required this.id, required this.email});

  @override
  List<Object?> get props => [id, email];
}

class EmployeesCreatingAccountEntities extends Equatable {
  final String id;
  final String idToken;
  final String empEmail;
  final String empPassword;
  final String empName;
  final String empPhone;
  final String empPic;
  final String empLvl;

  const EmployeesCreatingAccountEntities({
    required this.id,
    required this.idToken,
    required this.empEmail,
    required this.empPassword,
    required this.empName,
    required this.empPhone,
    required this.empPic,
    required this.empLvl,
  });
  @override
  List<Object?> get props => [
    id,
    idToken,
    empEmail,
    empPassword,
    empName,
    empPhone,
    empPic,
    empLvl,
  ];
}
