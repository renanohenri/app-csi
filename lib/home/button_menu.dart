import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ButtonMenu extends StatelessWidget {
  final String? name;
  final IconData? icon;

  ButtonMenu({required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.4,
      height: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Colors.grey[50],
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 3,
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 42,
            color: Color(0xFFD35D35),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '${name}',
            style: TextStyle(
                fontSize: 20,
                color: Color(0xFF273B5A),
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
