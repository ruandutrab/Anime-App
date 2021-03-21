import 'package:anime_app/models/animes/anime_list.dart';
import 'package:anime_app/models/sub_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeAnime extends StatelessWidget {
  final String idAnime;
  final String nomeAnime;
  final String imgCard;
  final String description;
  final String releaseYear;
  final String completed;

  const HomeAnime({
    Key key,
    this.nomeAnime,
    this.imgCard,
    this.description,
    this.releaseYear,
    this.completed,
    this.idAnime,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 25,
              child: Container(
                width: MediaQuery.of(context).size.width / 1,
                child: SubBar(),
              ),
            ),
            Container(
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 80, 10, 0),
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: [
                        //  Titulo do anime
                        Center(
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.grey[850],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text(
                                '$nomeAnime',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        //  ..................
                        //  Imagem do card
                        Container(
                          margin: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(
                              color: Colors.grey[850],
                              width: 5,
                            ),
                          ),
                          child: ClipRRect(
                            child: Image.network('$imgCard'),
                          ),
                        ),
                        //  ..................
                      ],
                    ),
                    Stack(
                      children: [
                        Positioned(
                          top: 35,
                          right: 10,
                          child: Container(
                            width: 30,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.grey[850],
                                borderRadius: BorderRadius.circular(50)),
                            child: IconButton(
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                onPressed: () {}),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Positioned(
                          top: 35,
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.grey[850],
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Text(
                              '$releaseYear',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Positioned(
                          top: 60,
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Text(
                              '$completed',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Linha de seperação
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 225,
                          child: Container(
                            height: 0.5,
                            width: 350,
                            color: Colors.grey[850],
                          ),
                        ),
                      ],
                    ),
                    //  ..................
                    //  Botão com a lista de episódios
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Positioned(
                          top: 230,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AnimeList(
                                    idAnime: idAnime,
                                    nomeAnime: nomeAnime,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: MediaQuery.of(context).size.width / 1.3,
                              child: Text(
                                'Lista de Episódios',
                                style: TextStyle(fontSize: 19),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //  ..................
                    //  Botão de soluções
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Positioned(
                          top: 275,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.red[400]),
                            onPressed: () {},
                            child: Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: MediaQuery.of(context).size.width / 1.3,
                              child: Text(
                                'Soluções de Problemas',
                                style: TextStyle(fontSize: 19),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //  ..................
                    // Linha de seperação
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 330,
                          child: Container(
                            height: 0.5,
                            width: 350,
                            color: Colors.grey[850],
                          ),
                        ),
                      ],
                    ),
                    //  ..................
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 340,
                          child: Container(
                            padding: EdgeInsets.all(9),
                            width: 350,
                            decoration: BoxDecoration(
                                color: Colors.grey[900],
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              '$description',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ], //final
        ));
  }
}
