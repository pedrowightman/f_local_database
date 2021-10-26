import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loggy/loggy.dart';
import 'core/network_info.dart';
import 'data/models/userdb.dart';
import 'data/repositories/user_repository.dart';
import 'domain/controllers/home_controller.dart';
import 'ui/home.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

Future<List<Box>> _openBox() async {
  List<Box> boxList = [];
  var dir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(UserDBAdapter());
  var user_session = await Hive.openBox("users");
  boxList.add(user_session);
  return boxList;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _openBox();
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );
  Get.put(Connectivity());
  Connectivity c = Get.find();
  Get.put(NetworkInfo(connectivity: c));
  Get.put(UserRepository());
  Get.put(HomeController());
  runApp(Home());
}
