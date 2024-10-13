

import 'package:flutter/material.dart';

Future<String?> showConfirmDialog(BuildContext context, String displayMessage) async{
  AlertDialog dialog = AlertDialog(
    title: Text("Xác nhận"),
    content: Text(displayMessage),
    actions: [
      ElevatedButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop("cancel");
          },
          child: Text("Hủy")
      ),
      ElevatedButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop("ok");
          },
          child: Text("Ok")
      ),
    ],
  );
  String? res = await showDialog<String?>(
    barrierDismissible: false,
    context: context,
    builder: (context) => dialog,
  );

  return res;
}