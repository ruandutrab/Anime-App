import 'package:anime_app/app/controller/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContatoPage extends StatefulWidget {
  @override
  _ContatoPageState createState() => _ContatoPageState();
}

HomeController _homeController = Get.find<HomeController>();
var msgCounter;
TextEditingController _textController = TextEditingController();
String nome = _homeController.userModel.nome;
String email = _homeController.userModel.email;
var mainDb = FirebaseFirestore.instance.collection('users').doc('$email');
final notSend = SnackBar(
  content: Text(
    "Limite de mensagem excedido!",
    style: TextStyle(color: Colors.red, fontSize: 15),
  ),
  action: SnackBarAction(
    label: 'Fechar',
    onPressed: () {},
  ),
);
final sendMsg = SnackBar(
  content: Text(
    "Mensagem enviada com sucesso!",
    style: TextStyle(color: Colors.green, fontSize: 15),
  ),
  action: SnackBarAction(
    label: 'Fechar',
    onPressed: () {},
  ),
);

class _ContatoPageState extends State<ContatoPage> {
  @override
  @override
  void initState() {
    msgCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> dataList = [];

    String msgAviso =
        // ignore: unnecessary_brace_in_string_interps
        "     Olá ${nome}, use esse campo para dar a sua opnião sobre o nosso App, ou para dar sugestão de animes.";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[500],
        title: Text(
          'Contato',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Container(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(
                MediaQuery.of(context).size.height * .02,
              ),
              child: Text(
                '$msgAviso',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              // padding: EdgeInsets.only(left: 5),
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.height * .06,
                  left: MediaQuery.of(context).size.height * .06,
                  top: MediaQuery.of(context).size.height * .03),
              child: TextFormField(
                readOnly: true,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: '$nome',
                  labelText: 'Nome',
                  hintStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(fontSize: 20, color: Colors.cyan),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Container(
              // padding: EdgeInsets.only(left: 5),
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.height * .06,
                  left: MediaQuery.of(context).size.height * .06,
                  top: MediaQuery.of(context).size.height * .01),

              child: TextFormField(
                readOnly: true,
                keyboardType: TextInputType.name,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: '$email',
                  labelText: 'E-mail',
                  hintStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(fontSize: 20, color: Colors.cyan),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.blue,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.height * .06,
                  left: MediaQuery.of(context).size.height * .06,
                  top: MediaQuery.of(context).size.height * .01),
              child: Container(
                // height: MediaQuery.of(context).size.height * 50,
                // margin: EdgeInsets.all(5),
                child: TextFormField(
                  controller: _textController,
                  maxLength: 300,
                  maxLines: 8,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Mensagem',
                    alignLabelWithHint: true,
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 8.0),
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.cyan,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                right: MediaQuery.of(context).size.height * .06,
                left: MediaQuery.of(context).size.height * .06,
              ),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    msgCounter++;
                  });
                  if (msgCounter <= 3) {
                    mainDb.update({
                      'msg_count': FieldValue.increment(1),
                    });
                    dataList.insert(
                        0,
                        ({
                          "nome": nome,
                          "email": email,
                          "msg": _textController.text,
                        }));

                    mainDb.update({
                      'msg': FieldValue.arrayUnion(dataList),
                    });
                    ScaffoldMessenger.of(context).showSnackBar(sendMsg);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(notSend);
                  }
                  // ignore: unused_element
                  void dispose() {
                    // Clean up the controller when the widget is removed from the
                    // widget tree.
                    _textController.dispose();
                    super.dispose();
                  }
                },
                child: Text(
                  "Enviar",
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.green[600],
                    textStyle: TextStyle(fontSize: 20),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  msgCount() async {
    HomeController _homeController = Get.find<HomeController>();
    var db = await FirebaseFirestore.instance
        .collection('users')
        .doc(_homeController.userModel.email)
        .get();
    setState(() {
      if (msgCounter == null) {
        mainDb.update({'msg_count': 0});
      }
      msgCounter = db.data()['msg_count'];
    });
    return msgCounter;
  }
}
