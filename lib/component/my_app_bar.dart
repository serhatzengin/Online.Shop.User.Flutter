import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  bool show;
  final String name;

  @override
  final Size preferredSize;

  CustomAppBar({Key? key, required this.show, required this.name})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xffffffff),
      title: Text(name),
      // leading: IconButton(
      //   icon: const Icon(Icons.arrow_back_ios),
      //   onPressed: () => Navigator.of(context).pop(),
      // ),
      actions: [show == true ? const Icon(Icons.search) : const Icon(null)],
      automaticallyImplyLeading: true,
    );
  }
}
