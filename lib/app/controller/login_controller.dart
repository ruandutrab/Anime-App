import 'package:anime_app/app/data/repository/login.repository.dart';
import 'package:anime_app/app/data/model/user_model.dart';
import 'package:anime_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final LoginRepository repository = LoginRepository();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController nameTextController = TextEditingController();
  GetStorage box = GetStorage();

  @override
  void onReady() {
    isLogged();
    super.onReady();
  }

  void isLogged() {
    if (box.hasData('auth')) {
      UserModel userModel = UserModel(
          id: box.read('auth')['id'],
          email: box.read('auth')['email'],
          nome: box.read('auth')['nome'],
          urlimage: box.read('auth')['urlimage']);
      Get.offAllNamed(Routes.HOME, arguments: userModel);
    }
  }

  void register() async {
    Get.dialog(
        Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false);
    UserModel userModel = await repository.createUserWithEmailAndPassword(
        emailTextController.text,
        passwordTextController.text,
        nameTextController.text);
    if (userModel != null) {
      box.write('auth', userModel);
      Get.offAllNamed('/', arguments: userModel);
    }
  }

  void login() async {
    Get.dialog(
        Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false);
    UserModel userModel = await repository.signInWithEmailAndPassword(
        emailTextController.text, passwordTextController.text);

    if (userModel != null) {
      box.write('auth', userModel);
      Get.offAllNamed(
        Routes.HOME,
        arguments: userModel,
      );
    }
  }

  void logout() {
    repository.signOut();
  }
}
