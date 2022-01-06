import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? pressed;

  const CustomButton({
    Key? key,
    required this.buttonText,
    this.pressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(14),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 5,
            primary: Colors.white,
            padding: const EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        onPressed: pressed,
        child: Text(
          buttonText,
          style: const TextStyle(
              color: Color(0xff5ac18e),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
