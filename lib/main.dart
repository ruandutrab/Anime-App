import 'package:anime_app/app/ui/android/template/style.dart';
import 'package:anime_app/routes/app_pages.dart';
import 'package:anime_app/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAxzFzW8Z3VWjFe7pzEL50twConh1MlRV8",
          appId: "1:906897181814:android:72e7198ce358c90619e357",
          messagingSenderId: "",
          projectId: "906897181814"));
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
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
      ),
    );
  }
}
