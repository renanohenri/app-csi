import 'dart:convert';

import 'package:app_csi/models/agenda.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  static var client = http.Client();
  static String token = "";

  static Future<dynamic> authenticate(email, senha) async {
    final headers = {"Content-Type": "application/json"};
    final user = {"email": email, "password": senha};
    final String url = 'http://10.0.0.119:3001/authenticate';

    final response = await client.post(Uri.parse(url),
        headers: headers, body: json.encode(user));

    final body = jsonDecode(response.body);

    if (body.containsKey("token")) {
      token = 'Bearer ' + body["token"];
    }

    return body;
  }

  static Future<dynamic> getAgenda(int usuario) async {
    String url = 'http://10.0.0.119:3001/agendas/' + usuario.toString();
    var headerAuth = {"Authorization": token};

    var response = await client.get(Uri.parse(url), headers: headerAuth);
    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);
      return decode;
    } else {
      return null;
    }
  }

  static Future<dynamic> deleteAgenda(int id) async {
    String url = 'http://10.0.0.119:3001/agendas/' + id.toString();
    var headerAuth = {"Authorization": token};

    var response = await client.delete(Uri.parse(url), headers: headerAuth);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> getDisponibilidade(String dado, int periodo) async {
    String url = 'http://10.0.0.119:3001/disponibilidade/' +
        dado +
        "/" +
        periodo.toString();
    var headerAuth = {"Authorization": token};

    var response = await client.get(Uri.parse(url), headers: headerAuth);
    return int.parse(response.body);
  }

  Future<int> postAgenda(Agenda agenda) async {
    String url = 'http://10.0.0.119:3001/agendas';

    final headers = {
      "Content-Type": "application/json",
      "Authorization": token
    };

    final body = {
      "data_agendamento": agenda.dataAgendamento,
      "user_id": agenda.usuarioId,
      "qtd_solicitada_ipad": agenda.qtdSolicitadaIpda,
      "periodo_aula": agenda.periodo
    };

    var response = await client.post(Uri.parse(url),
        headers: headers, body: json.encode(body));
    if (response.statusCode == 200) {
      return 200;
    }
    return response.statusCode;
  }
}
