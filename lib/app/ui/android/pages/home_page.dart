import 'package:anime_app/app/controller/home_controller.dart';
import 'package:anime_app/app/controller/login_controller.dart';
import 'package:anime_app/app/ui/android/model/lancamentos.dart';
import 'package:anime_app/app/ui/android/model/mais_visto.dart';
import 'package:anime_app/app/ui/android/model/sub_bar.dart';
import 'package:anime_app/routes/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    final avatar = _homeController.userModel.urlimage == null
        ? CircleAvatar(
            radius: 30.0,
            child: Icon(
              Icons.person,
              size: 70,
            ),
          )
        : CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(
                'https://scontent.fsdu31-1.fna.fbcdn.net/v/t1.6435-9/94612538_10221640301066422_5891628298890379264_n.jpg?_nc_cat=102&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=Ai3SzqDf2DUAX-GnS0n&_nc_ht=scontent.fsdu31-1.fna&oh=c88185332e0650a3bf5609c0dadf82a9&oe=608E8163'),
          );
    return Scaffold(
      drawer: Drawer(
        elevation: 1.5,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                "${_homeController.userModel.nome}",
                style: TextStyle(fontSize: 20),
              ),
              accountEmail: Text("${_homeController.userModel.email}"),
              currentAccountPicture: avatar,
            ),

            ListTile(
              title: Text('Settings'),
              leading: Icon(Icons.settings),
              onTap: () {},
            ),
            // ListTile(
            //   title: Text('New'),
            //   leading: Icon(Icons.add),
            //   onTap: () {},
            // ),
            ListTile(
                title: Text('Logout'),
                leading: Icon(Icons.exit_to_app),
                onTap: () {
                  Get.offAllNamed(Routes.LOGIN);
                  LoginController().logout();
                }),
            Container(
              color: Colors.black,
              width: double.infinity,
              height: 0.1,
            ),
            Center(
              child: Container(
                  padding: EdgeInsets.all(10),
                  height: 100,
                  child: Text(
                    "V0.0.3 Beta",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        shadowColor: Colors.black,
        title: Text('Animax',
            style: GoogleFonts.orbitron(
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: 25)),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('home_page').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Carregando...')
                ],
              ),
            );
          }
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
    );
  }
}
