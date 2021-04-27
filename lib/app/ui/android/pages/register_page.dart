import 'package:anime_app/app/controller/login_controller.dart';
import 'package:anime_app/app/ui/android/template/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatelessWidget {
  final LoginController _loginController = Get.find<LoginController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.primaryDark(),
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Positioned(
              child: Image.asset(
                'images/op-2.png',
                // height: MediaQuery.of(context).size.height,
              ),
            ),
            Column(
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Animax',
                        style: GoogleFonts.orbitron(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 35),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: _loginArea(context),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 0.5,
                        // offset: Offset(0, 3),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 25,
                      right: 25,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          controller: _loginController.nameTextController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Campo obrigatório!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Nome',
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 25.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _loginController.emailTextController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Campo obrigatório!';
                            } else if (!GetUtils.isEmail(value)) {
                              return 'E-mail é inválido!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'E-mail',
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 25.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _loginController.passwordTextController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Campo obrigatório!';
                            } else if (value.length < 6) {
                              return 'Campo requer mínimo 6 caracteres.';
                            }
                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 55,
                              width: MediaQuery.of(context).size.width * .95,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    side:
                                        BorderSide(color: Style.primaryDark()),
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    _loginController.register();
                                  }
                                },
                                child: Text(
                                  'CADASTRAR',
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 22),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                child: Text(
                                  'Voltar',
                                  style: TextStyle(
                                    color: Style.secondaryDark(),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () {
                                  Get.back();
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double _loginArea(BuildContext context) {
    double totalArea = MediaQuery.of(context).size.height;
    double areaDisponivel =
        totalArea - MediaQuery.of(context).viewInsets.bottom;
    double loginArea = MediaQuery.of(context).size.height * .6;

    var resultado = loginArea > areaDisponivel ? areaDisponivel : loginArea;

    return resultado;
  }
}
