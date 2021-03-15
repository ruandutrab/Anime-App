import 'dart:ui';
import 'package:anime_app/models/animes/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimeList extends StatelessWidget {
  final String idAnime;
  final String nomeAnime;

  const AnimeList({Key key, this.idAnime, this.nomeAnime}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: Text(nomeAnime),
        centerTitle: true,
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(idAnime)
              .orderBy('episodio', descending: false)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              // scrollDirection: Axis.vertical,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int i) {
                var docs = snapshot.data.docs[i];

                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.grey[850]),
                    ),
                  ),
                  padding: EdgeInsets.all(4),
                  child: Stack(
                    children: [
                      Container(
                        child: Stack(
                          children: [
                            ClipRRect(
                              child: Image.network(
                                docs.data()['img_card'],
                                width: 100,
                                height: 100,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            // color: Colors.white.withOpacity(0.9),
                            height: 105,
                            width: 230,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 110,
                                  bottom: 49,
                                  child: Text(
                                    'Episódio: ${docs.data()['episodio']}',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            child: Container(
                              width: double.infinity,
                              height: 110,
                              // color: Colors.white.withOpacity(0.9),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MediaPlayer(
                                        linkEp: docs.data()['link'],
                                        nome: docs.data()['nome'],
                                        episodio: docs.data()['episodio'],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
