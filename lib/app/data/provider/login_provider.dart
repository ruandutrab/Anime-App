import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../ui/android/model/user_model.dart';

class LoginApiClient {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GetStorage box = GetStorage();

  // Retorna usuário logado.
  Stream<UserModel> get authStateChanged => _firebaseAuth
      .authStateChanges()
      .map((User currentUser) => UserModel.fromSnapshot(currentUser));
  // Cria usuário.
  Future<UserModel> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      final currentUser = (await _firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;

      FirebaseFirestore.instance
          .collection('users')
          .doc('${currentUser.email}')
          .set({
        'nome': '${currentUser.displayName}',
        'favorite': Map(),
        'lastview': Map(),
      });
      // Atualizar o nome do usuário.
      await currentUser.updateDisplayName(name);
      await currentUser.reload();

      return UserModel.fromSnapshot(currentUser);
    } catch (e) {
      print(e.code);
      Get.back();
      switch (e.code) {
        case 'email-already-in-use':
          Get.defaultDialog(
              title: "ERROR",
              content: Text('E-mail de usuário já cadastrado.'));
          break;
        case 'operation-not-allowed':
          Get.defaultDialog(
              title: "ERROR",
              content: Text('Contas anônimas não estão habilitadas.'));
          break;
        case 'weak-password':
          Get.defaultDialog(
              title: "ERROR", content: Text('Sua senha é muito fraca.'));
          break;
        case 'invalid-email':
          Get.defaultDialog(
              title: "ERROR", content: Text('Seu e-mail é inválido.'));
          break;
        case 'invalid-credential':
          Get.defaultDialog(
              title: "ERROR", content: Text('Seu e-mail é inválido.'));
          break;
        default:
          Get.defaultDialog(title: 'ERROR', content: Text('$e'));
          break;
      }
      return null;
    }
  }

  // Realiza login
  Future<UserModel> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final currentUser = (await _firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      return UserModel.fromSnapshot(currentUser);
    } catch (e) {
      print(e.code);
      Get.back();
      switch (e.code) {
        case 'user-not-found':
          Get.defaultDialog(
              title: "ERROR", content: Text('Usuário não encontrado.'));
          break;
        case 'wrong-password':
          Get.defaultDialog(
              title: "ERROR",
              content: Text('Senha não confere com o cadastro.'));
          break;
        case 'user-disabled':
          Get.defaultDialog(
              title: "ERROR", content: Text('Esté usuário foi desativado.'));
          break;
        case 'too-many-requests':
          Get.defaultDialog(
              title: "ERROR",
              content: Text(
                  'Muitas solicitações eventidas. Tente novamente mais tarde.'));
          break;
        case 'operation--not-allowed':
          Get.defaultDialog(
              title: "ERROR", content: Text('Este login não foi permitido.'));
          break;
        case 'unknown':
          Get.defaultDialog(
              title: "ERROR",
              content: Text('Campo de e-mail ou password vazio.'));
          break;
        default:
          Get.defaultDialog(title: 'ERROR', content: Text('$e'));
          break;
      }
      return null;
    }
  }

  Future<UserModel> singOut() {
    box.write('auth', null);
    return _firebaseAuth.signOut();
  }
}
