import 'package:app_csi/models/agenda.dart';
import 'package:app_csi/services/remote_services.dart';
import 'package:get/get.dart';

class AgendaController extends GetxController {
  final RemoteServices remoteServices = RemoteServices();

  var isLoadind = true.obs;
  var agendas = [].obs;
  var ipads = 0.obs;
  var ipad_disponivel = -1.obs;
  final List<DateTime> days = [];
  List<String> horarios = [
    '07:30',
    '08:15',
    '09:00',
    '09:45',
    '10:15',
    '11:00',
    '13:30',
    '14:15',
    '15:00',
    '15:45',
    '17:15',
    '18:00'
  ];

  void loadFiveDays() {
    DateTime now = DateTime.now();
    DateTime twoDaysFut = DateTime(now.year, now.month, now.day + 2);

    for (int i = 0; days.length < 5; i++) {
      if (twoDaysFut.weekday != 6 && twoDaysFut.weekday != 7) {
        days.add(twoDaysFut);
        twoDaysFut =
            new DateTime(twoDaysFut.year, twoDaysFut.month, twoDaysFut.day + 1);
      } else {
        twoDaysFut =
            new DateTime(twoDaysFut.year, twoDaysFut.month, twoDaysFut.day + 1);
      }
    }
  }

  Future<void> getAgenda(int usuario) async {
    agendas = [].obs;
    try {
      isLoadind(true);
      var agenda = await RemoteServices.getAgenda(usuario);
      if (agenda != null) {
        for (var a in agenda) {
          agendas.add(a);
          print(agendas);
        }
      }
    } finally {
      isLoadind(false);
    }
  }

  Future<void> deleteAgenda(int id) async {
    try {
      isLoadind(true);
      await RemoteServices.deleteAgenda(id);
    } finally {
      isLoadind(false);
    }
  }

  increment() => ipad_disponivel++;

  Future<void> verificarDisponibilidade(String data, int periodo) async {
    int result = await remoteServices.getDisponibilidade(data, periodo);
    ipads.value = result;
  }

  Future<int> agendar(Agenda agenda) async {
    int status = await remoteServices.postAgenda(agenda);
    return status;
  }
}
