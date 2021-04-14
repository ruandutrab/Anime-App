import 'dart:convert';
import 'package:anime_app/app/ui/android/pages/home_anime.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// final HomeController _homeController = Get.find<HomeController>();

class FavoritoPage extends StatefulWidget {
  @override
  _FavoritoPageState createState() => _FavoritoPageState();
}

class _FavoritoPageState extends State<FavoritoPage> {
  List data;
  Future<String> getJSONData() async {
    // final url =
    //     Uri.parse('https://unsplash.com/napi/photos/Q14J2k8VE3U/related');
    final url = Uri.parse(
        'https://raw.githubusercontent.com/ruandutrab/apirestanime/main/animes/naruto.json');

    var response = await http.get(url);

    data = jsonDecode(response.body)['naruto'];

    print(data);
    return 'Dados obtidos';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          backgroundColor: Colors.blue[500],
          title: Text(
            'Favoritos',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ),
      body: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int i) {
          var item = data[i];

          print(item['nome']);
          // if (i >= 10) {
          //   return null;
          // }
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
                          item['img_card'],
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
                                        description: item.data()['description'],
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
      ),
    );
  }

  @override
  void initState() {
    this.getJSONData();
    print(data);
    super.initState();
  }
}
