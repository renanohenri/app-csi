import 'package:app_csi/controllers/agendaController.dart';
import 'package:app_csi/controllers/usuarioController.dart';
import 'package:app_csi/global//header.dart';
import 'package:app_csi/global/loader.dart';
import 'package:app_csi/models/agenda.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AgendarScreen extends StatefulWidget {
  @override
  _AgendarScreen createState() => _AgendarScreen();
}

class _AgendarScreen extends State<AgendarScreen> {
  final AgendaController agendaController = Get.find();
  final TextEditingController _qtdIpadController = TextEditingController();
  final UsuarioController usuarioController = Get.find();
  final DateFormat formatD = DateFormat('yyyy-MM-dd');
  final DateFormat dateFormat = DateFormat('dd/MM');
  bool _validate = false;
  String? horario;
  int selected = 0;
  int selectedH = 0;
  bool loadingPage = false;

  Future<void> successOrFail(bool result) async {
    return showDialog<void>(
      context: context, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                result != true
                    ? Icon(
                        CupertinoIcons.clear_circled_solid,
                        color: Colors.red,
                        size: 100,
                      )
                    : Icon(
                        CupertinoIcons.check_mark_circled_solid,
                        color: Colors.green,
                        size: 100,
                      ),
                result != true
                    ? Text('Falha ao agendar, tente novamente mais tarde!')
                    : Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Agendamento do dia ' +
                              dateFormat
                                  .format(agendaController.days[selected]) +
                              ' no período das ' +
                              agendaController.horarios[selectedH] +
                              ' realizado com sucesso!',
                          textAlign: TextAlign.center,
                        ),
                      )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                _qtdIpadController.text = '';
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) => loadingPage
      ? LoaderClass()
      : Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Color(0xFFD35D35),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          backgroundColor: Colors.white,
          bottomNavigationBar: Stack(
            children: [
              Row(
                children: [
                  new InkWell(
                    onTap: _qtdIpadController.text.isEmpty
                        ? null
                        : () async {
                            setState(() {
                              int.parse(_qtdIpadController.text) >
                                      agendaController.ipads.value
                                  ? _validate = true
                                  : _validate = false;
                            });

                            if (_validate != true) {
                              setState(() {
                                loadingPage = true;
                              });
                              final result = await agendaController.agendar(
                                  Agenda(
                                      dataAgendamento: formatD.format(
                                          agendaController.days[selected]),
                                      usuarioId:
                                          usuarioController.usuario.value.id,
                                      qtdSolicitadaIpda:
                                          int.parse(_qtdIpadController.text),
                                      periodo: selectedH + 1));

                              setState(() {
                                loadingPage = false;
                              });

                              if (result == 200) {
                                successOrFail(true);
                                await agendaController.verificarDisponibilidade(
                                    formatD.format(
                                        agendaController.days[selected]),
                                    (selectedH + 1));
                              } else {
                                successOrFail(false);
                                await agendaController.verificarDisponibilidade(
                                    formatD.format(
                                        agendaController.days[selected]),
                                    (selectedH + 1));
                              }
                            }
                          },
                    child: Container(
                        color: _qtdIpadController.text.isEmpty
                            ? Color(0xFF5E7290)
                            : Color(0xFF273B5A),
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 1,
                        child: Center(
                          child: Text(
                            'Agendar',
                            style: TextStyle(
                                color: _qtdIpadController.text.isEmpty
                                    ? Colors.grey[50]
                                    : Colors.white,
                                fontSize: 18),
                          ),
                        )),
                  ),
                ],
              )
            ],
          ),
          body: ListView(
            children: [
              Header(context, 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 10), // changes position of shadow
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width * 0.95,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          'Agendar',
                          style: TextStyle(
                              fontSize: 24,
                              color: Color(0xFFD35D35),
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text('Selecione uma data e uma período'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: SizedBox(
                          height: 100,
                          // width: size.width * 9,
                          child: ListView.builder(
                            itemCount: agendaController.days.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    selected = index;
                                  });
                                  // context.loaderOverlay.show();
                                  await agendaController
                                      .verificarDisponibilidade(
                                          formatD.format(
                                              agendaController.days[selected]),
                                          (selectedH + 1));
                                  // context.loaderOverlay.show();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: ((MediaQuery.of(context).size.width -
                                          (MediaQuery.of(context).size.width *
                                              0.1)) /
                                      5),
                                  // height: 70,
                                  decoration: BoxDecoration(
                                      color: selected == index
                                          ? Color(0xFFD35D35)
                                          : Colors.white,
                                      border: Border.all(
                                          color: selected == index
                                              ? Color(0xFFD35D35)
                                              : Colors.black)),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          dateFormat.format(
                                              agendaController.days[index]),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: selected == index
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                        Text(
                                          DateFormat('EEE', "pt_BR").format(
                                              agendaController.days[index]),
                                          style: TextStyle(
                                            color: selected == index
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        // width: size.width * 9,
                        child: ListView.builder(
                          itemCount: agendaController.horarios.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                setState(() {
                                  selectedH = index;
                                });
                                // context.loaderOverlay.show();
                                await agendaController.verificarDisponibilidade(
                                    formatD.format(
                                        agendaController.days[selected]),
                                    (selectedH + 1));
                                // context.loaderOverlay.show();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: ((MediaQuery.of(context).size.width -
                                        (MediaQuery.of(context).size.width *
                                            0.1)) /
                                    5),
                                // height: 70,
                                decoration: BoxDecoration(
                                    color: selectedH == index
                                        ? Color(0xFF273B5A)
                                        : Colors.white,
                                    border: Border.all(
                                        color: selectedH == index
                                            ? Color(0xFF273B5A)
                                            : Colors.black)),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        agendaController.horarios[index],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: selectedH == index
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () => Text(
                                "${agendaController.ipads.value}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 60),
                              ),
                            ),
                            Text(
                              'Ipads disponíveis',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0)),
                ),
                width: MediaQuery.of(context).size.width * 0.95,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Indique a quantidade de IPads'),
                      TextField(
                        controller: _qtdIpadController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            errorText: _validate
                                ? 'Quantidade de IPads indisponível'
                                : null),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
}
