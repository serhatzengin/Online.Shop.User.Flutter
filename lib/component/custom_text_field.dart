import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final IconData? icondata;
  final String? hintText;
  bool? isObsecre = true;
  bool? enabled = true;
  final TextInputType? keyboardType;

  CustomTextField({
    Key? key,
    this.controller,
    this.icondata,
    this.hintText,
    this.isObsecre,
    this.enabled,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.all(4),
        child: TextFormField(
          keyboardType: keyboardType,
          enabled: enabled,
          controller: controller,
          obscureText: isObsecre!,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.black38),
            border: InputBorder.none,
            prefixIcon: Icon(icondata, color: Colors.cyan),
          ),
        ),
      ),
    );
  }
}
