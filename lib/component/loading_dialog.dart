import 'package:flutter/material.dart';

import 'progress_bar.dart';

class LoadingDialog extends StatelessWidget {
  final String? message;

  const LoadingDialog({
    Key? key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          circularProgress(),
          const SizedBox(height: 20),
          Text(message! + "Please wait...")
        ],
      ),
    );
  }
}
