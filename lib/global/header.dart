import 'package:app_csi/controllers/usuarioController.dart';
import 'package:app_csi/login/login_screen.dart';
import 'package:app_csi/services/remote_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

Widget Header(BuildContext context, double topPadding) {
  final size = MediaQuery.of(context).size;
  final UsuarioController usuarioController = Get.find();

  return Stack(
    children: [
      Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  size.width * 0.05, topPadding, size.width * 0.05, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Olá, ',
                        style: TextStyle(
                          fontSize: 26,
                          color: Color(0xFF273B5A),
                        ),
                      ),
                      Obx(() {
                        return Text(
                          '${usuarioController.usuario.value.name}',
                          style: TextStyle(
                              fontSize: 26,
                              color: Color(0xFF273B5A),
                              fontWeight: FontWeight.w900),
                        );
                      })
                    ],
                  ),
                  InkWell(
                    onTap: () =>
                        {RemoteServices.token = "", Get.offAll(LoginScreen())},
                    child: Icon(
                      CupertinoIcons.share_up,
                      size: 36,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Color(0xFFD35D35),
              thickness: 2,
            ),
          ],
        ),
      ),
    ],
  );
}
