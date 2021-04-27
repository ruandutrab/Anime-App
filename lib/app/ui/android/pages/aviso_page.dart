import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AvisoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = DateTime.now();
    var dia = data.day;
    var mes = data.month;

    print(mes);
    final _db = FirebaseFirestore.instance
        .collection('avisos')
        .orderBy('date', descending: true)
        .snapshots();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[500],
          title: Text(
            'Avisos',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: _db,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, int i) {
                  final item = snapshot.data.docs[i];
                  return Stack(
                    children: [
                      i == 0
                          ? Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 4),
                                  child: ListTile(
                                      selected: false,
                                      isThreeLine: true,
                                      leading: Icon(Icons.email),
                                      title: Text(
                                        "${item.data()['title']}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                      subtitle: Text(
                                        "${item.data()['message']}",
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                      tileColor: Colors.grey[350]),
                                ),
                                Positioned(
                                  bottom: 55,
                                  left:
                                      MediaQuery.of(context).size.width / 1.25,
                                  child: RotationTransition(
                                    turns: AlwaysStoppedAnimation(50 / 360),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 20,
                                      width: 120,
                                      color: Colors.orange.withOpacity(0.5),
                                      child: Text(
                                        "News",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(
                              padding: EdgeInsets.only(bottom: 4),
                              child: ListTile(
                                  selected: false,
                                  isThreeLine: true,
                                  leading: Icon(Icons.email),
                                  title: Text(
                                    "${item.data()['title']}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  subtitle: Text(
                                    "${item.data()['message']}",
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                  tileColor: Colors.grey[350]),
                            )
                    ],
                  );
                });
          },
        ));
  }
}
