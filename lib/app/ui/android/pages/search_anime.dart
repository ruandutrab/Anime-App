import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchAnime extends StatelessWidget {
  final String nameSearch;

  const SearchAnime({Key key, this.nameSearch}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('animes_list')
                    .where(nameSearch)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Center(
                      child: Text('Aguardando dados...'),
                    );
                  }

                  return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int i) {
                      var items = snapshot.data.docs[i];
                      return Container(
                        child: Column(
                          children: [
                            Container(
                              child: Text(items.data()[nameSearch]),
                            )
                          ],
                        ),
                      );
                    },
                  );
                })
          ],
        ),
      ),
    );
  }
}
