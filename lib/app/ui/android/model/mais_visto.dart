import 'package:anime_app/app/ui/android/pages/home_anime.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MaisVisto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          backgroundColor: Colors.blue[500],
          title: Text(
            'Animes mais visto',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('animes_list')
            .orderBy('views', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error Inesperado ${snapshot.error}'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Carregando...')
                ],
              ),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Aguardando dados...')
                ],
              ),
            );
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext context, int i) {
              var item = snapshot.data.docs[i];
              if (i >= 10) {
                return null;
              }
              return Container(
                // color: Colors.grey[200],
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        String id = item.id;
                        // Captura o documento que foi clicado
                        FirebaseFirestore.instance
                            .collection('animes_list')
                            .doc(item.id)
                            .update({
                          'views': FieldValue.increment(1),
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeAnime(
                                      idAnime: id,
                                      nomeAnime: item.get('nome'),
                                      imgCard: item.get('img_card'),
                                      releaseYear: item.get('release_date'),
                                      description: item.get('description'),
                                      completed: item.get('completed'),
                                    )));
                      },
                      child: Container(
                        padding: EdgeInsets.all(3),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            ClipRRect(
                              child: Image.network(
                                item.get('img_card'),
                                height: 150,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            Container(
                              width: 100,
                              margin: EdgeInsets.all(2),
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Text(
                                item.get('nome'),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
