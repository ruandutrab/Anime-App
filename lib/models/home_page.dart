import 'package:anime_app/models/mais_visto.dart';
import 'package:anime_app/models/sub_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'animes/anime_list.dart';
import 'lancamentos.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: ('/'),
      routes: <String, WidgetBuilder>{
        '/homepage': (BuildContext context) => HomePage(),
        '/animespage': (BuildContext context) => AnimeList(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue[500],
        accentColor: Colors.black,
      ),
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
        // backgroundColor: Colors.black45,
        body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('home_page').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error Inesperado ${snapshot.error}'),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: Text('Aguardando dados...'),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int i) {
                // var item = snapshot.data.documents[i];

                return Column(
                  children: [
                    SubBar(),
                    Container(
                      height: 200,
                      child: Lancamentos(),
                    ),
                    Container(
                      height: 200,
                      child: MaisVisto(),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
