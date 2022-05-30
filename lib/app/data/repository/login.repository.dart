import 'package:anime_app/app/data/provider/login_provider.dart';

import '../../ui/android/model/user_model.dart';

class LoginRepository {
  final LoginApiClient apiClient = LoginApiClient();

  Future<UserModel> createUserWithEmailAndPassword(
      String email, String password, String name) {
    return apiClient.createUserWithEmailAndPassword(email, password, name);
  }

  Future<UserModel> signInWithEmailAndPassword(String email, String password) {
    return apiClient.signInWithEmailAndPassword(email, password);
  }

  signOut() {
    apiClient.singOut();
  }
}
