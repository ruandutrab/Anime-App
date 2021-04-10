import 'package:anime_app/app/ui/android/pages/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Carregando...'),
                    ),
                  ],
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Erro!'),
                    ),
                  ],
                ),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Aguardando dados...'),
                    )
                  ],
                ),
              );
            }

            return ListView.builder(
              // scrollDirection: Axis.vertical,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int i) {
                var item = snapshot.data.docs[i];
                var _url = item.data()['link'];
                // ignore: unused_element
                void _launchURL() async => await canLaunch(_url)
                    ? await launch(_url)
                    : throw 'Could not launch $_url';

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MediaPlayer(
                          linkEp: '$_url',
                          nome: item.data()['nome'],
                          episodio: item.data()['episodio'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration:
                        BoxDecoration(border: Border.all(), color: Colors.blue),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ClipRRect(
                            child: Image.network(
                              item.data()['img_card'],
                              width: 100,
                              height: 100,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Episódio: ${item.data()['episodio']}',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
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
