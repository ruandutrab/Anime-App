import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String idColection;
    String numberEp;
    final db = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      body: Column(
        children: [
          Container(
            // Adicionar Episodio e Alterar
            child: ElevatedButton(
              child: Text('Not Click'),
              onPressed: () {
                db.collection('$idColection').doc('$numberEp').set({
                  "nome": "Naruto",
                  "linkep": 'link',
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
