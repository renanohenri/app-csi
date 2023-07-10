import 'package:app_csi/controllers/agendaController.dart';
import 'package:app_csi/controllers/usuarioController.dart';
import 'package:app_csi/global/header.dart';
import 'package:app_csi/global/loader.dart';
import 'package:app_csi/home/button_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final AgendaController agendaController = Get.put(AgendaController());
  final UsuarioController usuarioController = Get.put(UsuarioController());
  final DateFormat formatD = DateFormat('yyyy-MM-dd');
  bool loadingPage = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => loadingPage
      ? LoaderClass()
      : Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Header(context, 90),
              Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.15,
                      MediaQuery.of(context).size.height * 0.02,
                      MediaQuery.of(context).size.width * 0.15,
                      MediaQuery.of(context).size.width * 0.05),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      'Agende os dispotivos de modo fácil e rápido!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF273B5A),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.07,
                    20,
                    MediaQuery.of(context).size.width * 0.07,
                    0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          loadingPage = true;
                        });
                        agendaController.loadFiveDays();
                        await agendaController.verificarDisponibilidade(
                            formatD.format(agendaController.days[0]), (1));
                        setState(() {
                          loadingPage = false;
                        });
                        Get.toNamed('/agendar');
                      },
                      child: ButtonMenu(
                          name: 'Agendar', icon: CupertinoIcons.calendar),
                    ),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          loadingPage = true;
                        });
                        await agendaController
                            .getAgenda(usuarioController.usuario.value.id!);

                        Get.toNamed('/solicitacoes');
                        setState(() {
                          loadingPage = false;
                        });
                      },
                      child: ButtonMenu(
                          name: 'Solicitações', icon: CupertinoIcons.clock),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
}
