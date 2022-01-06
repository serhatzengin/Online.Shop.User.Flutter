import 'package:flutter/material.dart';

circularProgress() {
  return const Padding(
    padding: EdgeInsets.only(top: 12),
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.lightGreenAccent),
    ),
  );
}

linearProgress() {
  return const Padding(
    padding: EdgeInsets.only(top: 12),
    child: LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.lightGreen),
    ),
  );
}
