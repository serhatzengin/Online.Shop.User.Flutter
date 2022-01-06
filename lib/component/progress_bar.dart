import 'package:flutter/material.dart';

circularProgress() {
  return Container(
    alignment: Alignment.center,
    child: const Padding(
      padding: EdgeInsets.only(top: 12),
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.amber),
      ),
    ),
  );
}
