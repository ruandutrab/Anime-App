import 'dart:convert';
import 'package:anime_app/app/controller/home_controller.dart';
import 'package:anime_app/app/data/model/anime_model.dart';
import 'package:anime_app/app/services/anime_list_service.dart';
import 'package:anime_app/app/ui/android/pages/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AnimeList extends StatefulWidget {
  final String idAnime;
  final String nomeAnime;

  const AnimeList({Key key, this.idAnime, this.nomeAnime}) : super(key: key);

  @override
  _AnimeListState createState() => _AnimeListState();
}

class _AnimeListState extends State<AnimeList> {
  HomeController _homeController = Get.find<HomeController>();
  Views view = Views();
  final db = FirebaseFirestore.instance;
  var animes = [];
  bool views = false;
  List<String> viewArray = [];
  var viewName;

  _getAnime() async {
    AnimeApi.getAnime("${widget.idAnime}.json").then((response) {
      setState(() {
        Iterable lista = jsonDecode(response.body);
        animes = lista.map((model) => Anime.fromJson(model)).toList();
      });
    });
  }

  // getPlayerLink() async {
  //   AnimeApi.getLink().then((response) {
  //     Iterable ep = jsonDecode(response.body);
  //     var linkFull = ep.map((model) => GetLink.fromJson(model));
  //     link = linkFull.single.getLink;
  //   });
  // }

  @override
  void initState() {
    _getAnime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: Text(widget.nomeAnime),
        centerTitle: true,
      ),
      body: ListView.builder(
        // scrollDirection: Axis.vertical,
        itemCount: animes.length,
        itemBuilder: (BuildContext context, int i) {
          var _url = animes[i].link;

          // ignore: unused_element
          void _launchURL() async => await canLaunch(_url)
              ? await launch(_url)
              : throw 'Could not launch $_url';
          int index = 0;
          int animeLenght = view.getViews('${widget.idAnime}').length;
          if (animeLenght >= 1) {
            animeLenght = animeLenght - 1;
          }
          if (animes[i].episodio != view.getViews('${widget.idAnime}')[index]) {
            while ((animes[i].episodio !=
                    view.getViews('${widget.idAnime}')[index]) &
                (index < animeLenght)) {
              index++;
            }
          }
          return GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MediaPlayer(
                    linkEp: '$_url',
                    nome: animes[i].nome,
                    episodio: animes[i].episodio,
                  ),
                ),
              );
              viewArray.insert(0, (animes[i].episodio));

              FirebaseFirestore.instance
                  .collection('users')
                  .doc('${_homeController.userModel.email}')
                  .update({
                '${widget.idAnime}': FieldValue.arrayUnion(viewArray),
              });
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 4),
              child: ListTile(
                selected: false,
                isThreeLine: true,
                title: Text(
                  "${animes[i].nome}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                subtitle: Text(
                  "${animes[i].info}",
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                tileColor: animes[i].episodio ==
                        view.getViews('${widget.idAnime}')[index]
                    ? Colors.blue
                    : Colors.grey[300],
                trailing: IconButton(
                  icon: Icon(
                    Icons.report,
                    color: Colors.red,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Views {
  HomeController _homeController = Get.find<HomeController>();
  var dba;
  var email;
  List viewsAnime = [];
  String nomeAnime;
  getViews(String nomeAnime) {
    this.nomeAnime = nomeAnime;
    email = _homeController.userModel.email;
    dba = FirebaseFirestore.instance
        .collection('users')
        .doc('$email')
        .get()
        .then((value) => {viewsAnime = List.from(value.data()['$nomeAnime'])});
    if (viewsAnime.isEmpty) {
      viewsAnime.add("Empty");
    }
    return viewsAnime;
  }
}
