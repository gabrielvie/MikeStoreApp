import 'package:flutter/material.dart';

abstract class Dialogs {
  factory Dialogs._() => null;

  // static void show
  void showError(BuildContext context, String message,
      [String routeName = '']) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('An error occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              if (routeName.isEmpty) {
                Navigator.of(context).pop();
              }

              Navigator.of(context).pushNamed(routeName);
            },
            child: const Text('Ok'),
          )
        ],
      ),
    );
  }
}
