import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String id;
  String nome;
  String email;
  String urlimage;
  var favorite = <Map>[];

  UserModel({this.id, this.nome, this.email, this.urlimage, this.favorite});

  UserModel.fromSnapshot(User currentUser)
      : id = currentUser.uid,
        nome = currentUser.displayName,
        email = currentUser.email,
        urlimage = currentUser.photoURL == null
            ? 'https://flyclipart.com/thumb2/download-person-free-vector-png-137844.png'
            : currentUser.photoURL;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'urlimage': urlimage,
    };
  }
}
