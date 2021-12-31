import 'package:anime_app/app/ui/android/pages/all_favoritos.dart';
import 'package:anime_app/app/ui/android/pages/aviso_page.dart';
import 'package:anime_app/app/ui/android/pages/contato_page.dart';
import 'package:anime_app/app/ui/android/pages/home_page.dart';
import 'package:anime_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class SubBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          color: Colors.blueAccent,
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) => HomePage()));
                    },
                    child: Text(
                      'INICIAL',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )),
              Container(
                margin: EdgeInsets.all(7),
                child: Text(
                  '|',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ),
              Container(
                  child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => AllFavoritos()));
                    },
                    child: Text(
                      'FAVORITO',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )),
              Container(
                margin: EdgeInsets.all(7),
                child: Text(
                  '|',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ),
              Container(
                  child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AvisoPage()));
                    },
                    child: Text(
                      'AVISOS',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              )),
              Container(
                margin: EdgeInsets.all(7),
                child: Text(
                  '|',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ),
              Container(
                  child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContatoPage()));
                    },
                    child: Text(
                      'CONTADO',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              )),
            ],
          ),
        ),
      ],
    );
  }
}
