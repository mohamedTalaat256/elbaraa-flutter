import 'package:elbaraa/presentation/widgets/custome_text.dart';
import 'package:flutter/material.dart';



class CustomeButtonIcon extends StatelessWidget {
  
  final VoidCallback onPressed;
  final String text;
  final Color backgroundColor;
  final Color onSurface;
  final double borderRaduis;
  final double paddingAll;
  final Icon icon;
  final FontWeight fontWeight;
  final double fontSize;
final Color textColor;

  const CustomeButtonIcon({
    this.backgroundColor= const Color.fromRGBO(0, 197, 105, 1),
    this.onSurface= Colors.grey,
    this.borderRaduis= 2,
    this.paddingAll= 8,
    required this.icon,
    required this.onPressed,
    this.text ='',
    this.textColor =const Color.fromARGB(255, 255, 255, 255), 
    this.fontWeight = FontWeight.bold,
    this.fontSize = 16.0
  });

@override
Widget build(BuildContext context) {
  return TextButton(
    style: TextButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: textColor, // Replace surfaceTintColor
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(borderRaduis)),
      ),
    ),
    onPressed: onPressed,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8, left: 8),
          child: icon,
        ),
        CustomeText(
          text: text,
          color: textColor,
          fontWeight: fontWeight,
          fontSize: fontSize,
        )
      ],
    ),
  );
}
}