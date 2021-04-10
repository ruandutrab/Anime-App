import 'package:anime_app/app/ui/android/template/style.dart';
import 'package:anime_app/routes/app_pages.dart';
import 'package:anime_app/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(MaterialConf());
}

class MaterialConf extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppPage.routes,
      initialRoute: Routes.LOGIN,
      debugShowCheckedModeBanner: false,
      enableLog: false,
      theme: ThemeData(
        primaryColor: Style.primary(),
        accentColor: Colors.black,
      ),
    );
  }
}
