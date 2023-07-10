import 'package:app_csi/models/usuario.dart';
import 'package:app_csi/services/remote_services.dart';
import 'package:get/get.dart';

class UsuarioController extends GetxController {
  final RemoteServices remoteServices = RemoteServices();

  var isLoadind = true.obs;
  var usuario = Usuario().obs;

  @override
  void onInit() {
    // getUsuario();
    super.onInit();
  }

  // void getUsuario() async {

  //   try{
  //     isLoadind(true);
  //     var user = await RemoteServices.getUsuario();
  //     if (user != null ){
  //       usuario.value.id = user.id;
  //       usuario.value.name = user.name;
  //       usuario.value.departamentoId = user.departamentoId;
  //     }
  //   } finally{
  //     isLoadind(false);
  //   }

  // }

  Future<dynamic> auth(email, senha) async {
    final response = await RemoteServices.authenticate(email, senha);

    if (response['statusCode'] == 200) {
      usuario.value.id = response['user']['id'];
      usuario.value.name = response['user']['name'];
      print(usuario.value.name);
    }

    return response;
  }
}
