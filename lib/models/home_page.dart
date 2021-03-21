import 'package:anime_app/models/mais_visto.dart';
import 'package:anime_app/models/sub_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'animes/anime_list.dart';
import 'lancamentos.dart';
import 'package:google_fonts/google_fonts.dart';

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
        backgroundColor: Colors.black,
        appBar: AppBar(
          shadowColor: Colors.black,
          title:
              Text('Animes', style: GoogleFonts.orbitron(color: Colors.black)),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Login',
                  style: GoogleFonts.acme(fontSize: 22),
                ),
              )),
              Container(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: 'User',
                        hintText: 'Your user name.',
                      ),
                    ),
                    // User password.
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        labelText: 'Password',
                        hintText: 'Your password.',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
