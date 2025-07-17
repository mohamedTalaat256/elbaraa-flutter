import 'package:flutter/material.dart';

class IconTile extends StatelessWidget {
  final Icon icon;
  final Color backColor;

  IconTile({required this.icon, required this.backColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 12),
      child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              color: backColor, borderRadius: BorderRadius.circular(15)),
          child: icon),
    );
  }
}