import 'package:cloud_firestore/cloud_firestore.dart';

class DataModel {
  final String nome;
  // ignore: non_constant_identifier_names
  final String img_card;

  // ignore: non_constant_identifier_names
  DataModel({this.nome, this.img_card});

  //Create a method to convert QuerySnapshot from Cloud Firestore to a list of objects of this DataModel
  //This function in essential to the working of FirestoreSearchScaffold
  List<DataModel> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap = snapshot.data();

      return DataModel(nome: dataMap['nome'], img_card: dataMap['img_card']);
    }).toList();
  }
}
