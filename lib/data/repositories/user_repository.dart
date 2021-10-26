import 'package:f_local_database_sqlite/data/datasources/local/user_local_datasource_hive.dart';
import 'package:f_local_database_sqlite/data/datasources/local/user_local_datasource_sqflite.dart';
import 'package:f_local_database_sqlite/data/datasources/remote/user_remote_datasource.dart';
import 'package:f_local_database_sqlite/data/models/user_model.dart';
import 'package:loggy/loggy.dart';

class UserRepository {
  late UserRemoteDatatasource remoteDataSource;
  //late UserLocalDataSource localDataSource;
  late UserLocalDataSourceHive localDataSource;

  UserRepository() {
    logInfo("Starting UserRepository");
    remoteDataSource = UserRemoteDatatasource();
    //localDataSource = UserLocalDataSource();
    localDataSource = UserLocalDataSourceHive();
  }

  Future<bool> getUser() async {
    UserModel user = await remoteDataSource.getUser();
    await localDataSource.addUser(user);
    return Future.value(true);
  }

  Future<List<UserModel>> getAllUsers() async =>
      await localDataSource.getAllUsers();

  Future<void> deleteUser(id) async => await localDataSource.deleteUser(id);

  Future<void> deleteAll() async => await localDataSource.deleteAll();

  Future<void> updateUser(user) async => await localDataSource.updateUser(user);
}
