import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
                      Navigator.pushReplacementNamed(context, "/homepage");
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
                      Navigator.pushReplacementNamed(context, "/lancamentos");
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
                  Text(
                    'AVISOS',
                    style: TextStyle(color: Colors.white),
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
                  Text(
                    'CATEGORIA',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              )),
            ],
          ),
        ),
      ],
    );
  }
}
