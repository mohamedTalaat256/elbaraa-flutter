import 'package:flutter/material.dart';
import 'package:elbaraa/presentation/widgets/custome_text.dart';

class CustomeButton extends StatelessWidget {
  
  final VoidCallback onPressed;
  final String text;
  final Color backgroundColor;
  final Color onSurface;
  final Color textColor;
  final double borderRaduis;
  final double paddingAll;
  final FontWeight fontWeight;
  final double fontSize;


  const CustomeButton({
    this.backgroundColor= const Color.fromRGBO(0, 197, 105, 1),
    this.onSurface= Colors.grey,
    this.borderRaduis= 2,
    this.paddingAll= 8,
    required this.onPressed,
    this.text ='',
    this.textColor =Colors.white, 
    this.fontWeight = FontWeight.bold,
    this.fontSize = 16.0
   // required Null Function() onPress
  });

  @override
  Widget build(BuildContext context) {
     return TextButton(
    style: TextButton.styleFrom(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(borderRaduis)),
      ),
      foregroundColor: textColor, // Use this instead of 'onSurface'
    ),
    onPressed: onPressed,
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: CustomeText(
        text: text,
        color: textColor,
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
    ),
  );
  }
}