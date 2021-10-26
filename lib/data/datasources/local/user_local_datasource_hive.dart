import 'package:f_local_database_sqlite/data/models/user_model.dart';
import 'package:f_local_database_sqlite/data/models/userdb.dart';
import 'package:hive/hive.dart';
import 'package:loggy/loggy.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class UserLocalDataSourceHive {
  addUser(UserModel user) {
    Hive.box('users').add(UserDB(
        gender: user.gender,
        name: user.name,
        country: user.city,
        email: user.email,
        picture: user.picture));
  }

  Future<List<UserModel>> getAllUsers() async {
    return Hive.box('users').values.map<UserModel>((e) {
      return UserModel(
          id: e.key,
          name: e.name,
          city: e.country,
          email: e.email,
          picture: e.picture,
          gender: e.gender);
    }).toList();
  }

  deleteAll() async {
    logInfo("Deleting all from database");
    await Hive.box('users').clear();
  }

  deleteUser(index) async {
    await Hive.box('users').deleteAt(index);
  }

  updateUser(UserModel user) async {
    logInfo("Updating entry $user");
    await Hive.box('users').putAt(
        user.id!,
        UserDB(
            gender: user.gender,
            name: user.name,
            country: user.city,
            email: user.email,
            picture: user.picture));
  }
}
