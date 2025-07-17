
import 'package:flutter/material.dart';

class CustomeText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final TextAlign alignment;
  final FontWeight fontWeight;

  const CustomeText({super.key, 
     this.text='',
     this.fontSize=16,
     this.color = Colors.black,
     this.alignment = TextAlign.start,
     this.fontWeight = FontWeight.normal
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(text,
          style: TextStyle(
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight
          )),
    );
  }
}
