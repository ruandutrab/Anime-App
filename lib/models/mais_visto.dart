import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'animes/home_anime.dart';

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

              return Container(
                // color: Colors.grey[200],
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(3),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          ClipRRect(
                            child: Image.network(
                              item.data()['img_card'],
                              height: 150,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          Container(
                            margin: EdgeInsets.all(2),
                            padding: EdgeInsets.all(2),
                            // alignment: Alignment.bottomCenter,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Text(
                              item.data()['nome'],
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
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
                                            nomeAnime: item.data()['nome'],
                                            imgCard: item.data()['img_card'],
                                            releaseYear:
                                                item.data()['release_date'],
                                            description:
                                                item.data()['description'],
                                            completed: item.data()['completed'],
                                          )));
                            },
                            // The custom button
                            child: Container(
                              width: 100,
                              height: 150,
                              child: Container(
                                color: Colors.black.withOpacity(0),
                              ),
                            ),
                          ),
                        ],
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
