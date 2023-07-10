import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoaderClass extends StatelessWidget {
  const LoaderClass({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF263C59),
      body: Center(
        child: SpinKitCircle(
          size: 140,
          itemBuilder: (context, index) {
            final colors = [Colors.white, Color(0xFFD35D35)];
            final color = colors[index % colors.length];

            return DecoratedBox(decoration: BoxDecoration(color: color));
          },
        ),
      ),
    );
  }
}
