import 'package:anime_app/app/controller/home_controller.dart';
import 'package:anime_app/app/ui/android/pages/home_anime.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: unused_element
var favorite;
var favoriteTrue;
final HomeController _homeController = Get.find<HomeController>();
final _collection1 = FirebaseFirestore.instance.collection('users').snapshots();
final _collection2 =
    FirebaseFirestore.instance.collection('animes_list').snapshots();
String idAnime;

class FavoritoPage extends StatefulWidget {
  @override
  _FavoritoPageState createState() => _FavoritoPageState();
}

class _FavoritoPageState extends State<FavoritoPage> {
  @override
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
        stream: _collection1,
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshotUser) {
          return StreamBuilder(
              stream: _collection2,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshotAnimes) {
                if (!snapshotUser.hasData) return const Text('Loading...');
                if (!snapshotAnimes.hasData) return const Text('Loading...');
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshotAnimes.data.docs.length,
                  itemBuilder: (BuildContext context, int i) {
                    for (var item in snapshotUser.data.docs) {
                      favorite = item.data()['favorite'];
                    }

                    favorite.forEach((key, value) {
                      // print('index=$key, value=$value');
                      if (value == true) {
                        favoriteTrue = key;
                      }
                    });

                    print(favoriteTrue);

                    var item = snapshotAnimes.data.docs[i];

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
                                            nomeAnime: item.data()['nome'],
                                            imgCard: item.data()['img_card'],
                                            releaseYear:
                                                item.data()['release_date'],
                                            description:
                                                item.data()['description'],
                                            completed: item.data()['completed'],
                                          )));
                            },
                            child: Container(
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
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              });
        },
      ),
    );
  }
}
