import 'package:app_csi/bindings/initBinding.dart';
import 'package:app_csi/login/login_screen.dart';
import 'package:app_csi/solicitacoes/solicitacoes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';

import 'agendar/agendar_screen.dart';
import 'home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => LoginScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/agendar', page: () => AgendarScreen()),
        GetPage(name: '/solicitacoes', page: () => SolicitacoesScreen()),
      ],
      initialBinding: InitBindings(),
      debugShowCheckedModeBanner: false,
      // home: HomeScreen(),
    );
  }
}
