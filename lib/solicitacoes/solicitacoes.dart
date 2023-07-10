import 'package:app_csi/controllers/agendaController.dart';
import 'package:app_csi/controllers/usuarioController.dart';
import 'package:app_csi/global/header.dart';
import 'package:app_csi/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SolicitacoesScreen extends StatefulWidget {
  @override
  _SolicitacoesScreen createState() => _SolicitacoesScreen();
}

class _SolicitacoesScreen extends State<SolicitacoesScreen> {
  final AgendaController agendaController = Get.put(AgendaController());
  final UsuarioController usuarioController = Get.find();
  final DateFormat dateFormat = DateFormat("dd/MM/yyyy");

  Future<void> clear(int? id) async {
    return showDialog<void>(
      context: context, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: const SingleChildScrollView(
            child: ListBody(
              children: [
                Icon(
                  CupertinoIcons.trash_circle_fill,
                  color: Colors.red,
                  size: 100,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Você tem certeza que deseja excluir essa solicitação?',
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: const Text('Cancelar'),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  TextButton(
                    child: const Text('Excluir'),
                    onPressed: () async {
                      await agendaController.deleteAgenda(id!);
                      await agendaController
                          .getAgenda(usuarioController.usuario.value.id!);
                      Get.to(HomeScreen());
                    },
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFFD35D35),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Header(context, 10),
          Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.15,
                  MediaQuery.of(context).size.height * 0.02,
                  MediaQuery.of(context).size.width * 0.15,
                  MediaQuery.of(context).size.width * 0.05),
              child: Container(
                child: const Text(
                  'Solicitações',
                  style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFFD35D35),
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          agendaController.agendas.length > 0
              ? SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.72,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Obx(
                      () => ListView.builder(
                        itemCount: agendaController.agendas.length,
                        itemBuilder: (context, index) {
                          final horario = agendaController.agendas.value[index]
                              ["periodo_aula"];

                          var date = DateTime.parse(agendaController
                              .agendas.value[index]["data_agendamento"]
                              .toString());
                          date = date.add(const Duration(hours: -3));

                          return GestureDetector(
                            onTap: () {
                              clear(
                                  agendaController.agendas.value[index]["id"]);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: const Border(
                                    bottom: BorderSide(
                                      color: Color(0xFFD35D35),
                                      width: 1,
                                    ),
                                  ),
                                  color: Colors.grey[50],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Container(
                                    height: 80,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: Icon(
                                            CupertinoIcons
                                                .device_phone_portrait,
                                            color: agendaController.agendas
                                                            .value[index]
                                                        ['status'] ==
                                                    'DISPONIVEL'
                                                ? Colors.green
                                                : const Color(0xFF273B5A),
                                            size: 40,
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  'Data: ',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                Text(dateFormat.format(date)),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Período: ',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                // Obx(
                                                //   () => Text(''),
                                                // ),
                                                Text(''
                                                    '${agendaController.horarios[horario - 1]}')
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Nº de IPads solicitados:',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                Text(
                                                    ' ${agendaController.agendas.value[index]["qtd_solicitada_ipad"]}'),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )
              : const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text('Você não possui solicitações!'),
                  ),
                ),
        ],
      ),
    );
  }
}
