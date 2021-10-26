import 'package:f_local_database_sqlite/data/models/user_model.dart';
import 'package:f_local_database_sqlite/data/repositories/user_repository.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

class UserController extends GetxController {
  var _users = <UserModel>[].obs;
  UserRepository repository = Get.find();
  //List<UserModel> get getAllUsers =>

  List<UserModel> get users => _users;

  @override
  onInit() {
    super.onInit();
    getAllUsers();
  }

  Future<void> addUser() async {
    logInfo("userController -> add user");
    await repository.getUser();
    await getAllUsers();
  }

  Future<void> getAllUsers() async {
    logInfo("userController -> getAllUsers");
    var list = await repository.getAllUsers();
    _users.value = list;
  }

  Future<void> deleteUser(id) async {
    logInfo("userController -> delete user $id");
    await repository.deleteUser(id);
    await getAllUsers();
  }

  Future<void> deleteAll() async {
    logInfo("userController -> delete all");
    await repository.deleteAll();
    await getAllUsers();
  }

  Future<void> updateUser(user) async {
    logInfo("userController -> updateUser user ${user.id}");
    await repository.updateUser(user);
    await getAllUsers();
  }
}
