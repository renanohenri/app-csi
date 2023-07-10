import 'package:app_csi/controllers/agendaController.dart';
import 'package:app_csi/controllers/usuarioController.dart';
import 'package:get/get.dart';

class InitBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(UsuarioController());
    Get.put(AgendaController());
  }
}
