import 'package:anime_app/models/sub_bar.dart';
import 'package:flutter/material.dart';

class Style extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Animes'),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            )
          ],
        ),
        backgroundColor: Colors.black87,
        body: SubBar(),
      ),
    );
  }
}
