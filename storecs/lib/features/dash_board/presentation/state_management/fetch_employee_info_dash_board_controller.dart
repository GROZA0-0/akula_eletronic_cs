import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:storecs/features/dash_board/domain/entities/employee_info_entities.dart';
import 'package:storecs/features/dash_board/domain/repository/employee_info_repo.dart';

class FetchEmployeeInfoDashBoardController extends GetxController {
  final EmployeeInfoRepo repository;
  FetchEmployeeInfoDashBoardController({required this.repository});
  Rx<EmployeeInfoEntities> entities = const EmployeeInfoEntities(
    id: '',
    name: '',
    phone: '',
    userPic: '',
    level: '',
  ).obs;
  EmployeeInfoEntities blocEntities = const EmployeeInfoEntities(
    id: '',
    name: '',
    phone: '',
    userPic: '',
    level: '',
  );
  String get currentUid => FirebaseAuth.instance.currentUser!.uid;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    print('profile Controller onInit');
    if (currentUid.isNotEmpty) {
      getEmployeeInfo(currentUid);
    } else {
      print('No user logged in!');
    }
  }

  @override
  void onClose() {
    print('Dashboard Controller Destroyed');
    /* entities.value = const EmployeeInfoEntities(
      id: '',
      name: '',
      phone: '',
      userPic: '',
      level: '',
    ); */
    blocEntities = const EmployeeInfoEntities(
      id: '',
      name: '',
      phone: '',
      userPic: '',
      level: '',
    );
    super.onClose();
  }

  Future<EmployeeInfoEntities> getEmployeeInfo(String id) async {
    try {
      final infoOfDash = await repository.toEmployeeInfoRepo(id);
      print("info of user ${infoOfDash.name}${infoOfDash.level}");
      blocEntities = infoOfDash;
      // entities.value = infoOfDash;
      return blocEntities;
    } catch (e) {
      print("error in dashboard controller $e");
      throw e.toString();
    }
  }
}
