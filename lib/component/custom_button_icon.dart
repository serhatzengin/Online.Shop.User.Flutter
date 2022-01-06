import 'package:flutter/material.dart';

class CustomButtonIcon extends StatelessWidget {
  final String buttonText;
  final IconData icon;
  final VoidCallback pressed;

  const CustomButtonIcon({
    Key? key,
    required this.buttonText,
    required this.icon,
    required this.pressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 40,
      alignment: Alignment.center,
      child: ElevatedButton.icon(
        onPressed: pressed,
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        label: Text(buttonText),
        style: ElevatedButton.styleFrom(
          primary: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}

//https://stackoverflow.com/questions/64484113/the-argument-type-function-cant-be-assigned-to-the-parameter-type-void-funct