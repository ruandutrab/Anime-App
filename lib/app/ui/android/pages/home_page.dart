import 'package:anime_app/app/controller/home_controller.dart';
import 'package:anime_app/app/controller/login_controller.dart';
import 'package:anime_app/app/ui/android/model/lancamentos.dart';
import 'package:anime_app/app/ui/android/model/sub_bar.dart';
import 'package:anime_app/app/ui/android/pages/search_anime.dart';
import 'package:anime_app/routes/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/favoritos.dart';
import '../model/lacamentos_ano.dart';
import '../model/mais_visto.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> animes = [];
  @override
  void initState() {
    var userFavorite;
    Future<void> getFavorite() async {
      //query the user photo
      FirebaseFirestore.instance
          .collection("users")
          .doc('${_homeController.userModel.email}')
          .snapshots()
          .listen((event) {
        setState(() {
          userFavorite = event.get("favorite");
          userFavorite.forEach((key, value) {
            if (value == true) {
              animes.add(key);
            }
          });
        });
      });
    }

    super.initState();
    setState(() {
      getFavorite();
    });
  }

  final HomeController _homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    final avatar = CircleAvatar(
      radius: 30.0,
      child: Icon(
        Icons.person,
        size: 70,
      ),
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
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchAnime()));
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              SubBar(),
              Container(
                height: 200,
                child: Lancamentos(),
              ),
              Container(
                height: 200,
                child: MaisVisto(),
              ),
              animes.isEmpty
                  ? Container()
                  : Container(
                      height: 200,
                      child: FavoritoPage(),
                    ),
              Container(
                height: 200,
                child: LancamentosAno(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
