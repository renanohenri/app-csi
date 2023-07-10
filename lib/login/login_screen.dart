import 'package:app_csi/controllers/usuarioController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final UsuarioController usuarioController = Get.find();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  String error = "";

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Future<void> _showInfo() async {
      return showDialog<void>(
        context: context, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text('Atenção'),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [Center(child: Text('Preencha todos os campos'))],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                width: size.width,
                height: size.height * 0.25,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.bottomCenter,
                    radius: 0.9,
                    colors: [
                      Color(0xFF647A97),
                      Color(0xFF263C59),
                    ],
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 100),
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.all(Radius.circular(10)),
                  ),
                  child: new SvgPicture.asset(
                    'assets/images/image.svg',
                    width: 40,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Text(
                  'St. Isaac ',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFD35D35),
                  ),
                ),
                Text(
                  'Para toda Vida',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF263C59),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 40),
            child: Column(
              children: [
                Container(
                  width: size.width * 0.8,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFF263C59),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Icon(
                          CupertinoIcons.at,
                          color: Color(0xFFD35D35),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Container(
                            width: size.width * 0.6,
                            child: TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: 'Insira seu email',
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: size.width * 0.8,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFF263C59),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Icon(
                          CupertinoIcons.lock_fill,
                          color: Color(0xFFD35D35),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Container(
                            width: size.width * 0.6,
                            child: TextFormField(
                              obscureText: true,
                              controller: _senhaController,
                              decoration: InputDecoration(
                                hintText: 'Insira sua senha',
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    error != "" ? error : "",
                    style: TextStyle(color: Colors.red, fontSize: 18),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (_emailController.text == "" ||
                        _senhaController.text == "") {
                      await _showInfo();
                    } else {
                      var resp = await usuarioController.auth(
                          _emailController.text, _senhaController.text);

                      print(resp['token']);

                      if (resp['statusCode'] == 200) {
                        setState(() {
                          error = "";
                        });

                        Get.offAll(HomeScreen());
                      } else {
                        setState(() {
                          error = resp['error'];
                        });
                      }
                    }
                  },
                  child: Container(
                      width: size.width * 0.8,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color(0xFF263C59),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: Text(
                          'Entrar',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
