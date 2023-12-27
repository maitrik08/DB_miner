import 'package:db_miner/Database_helper.dart';
import 'package:db_miner/HomeScreen.dart';
import 'package:db_miner/SpashScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await QuoteHelper().initializeDatabase();
  await GetStorage.init();


  runApp(
      MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DB_miner',
      theme:ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: GetStorage().read("appTheme") == true ?ThemeMode.dark:ThemeMode.light,
      home: SplashScreen(),
    );
  }
}
