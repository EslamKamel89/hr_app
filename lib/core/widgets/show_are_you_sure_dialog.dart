import 'package:flutter/material.dart';
import 'package:hr/core/extensions/context-extensions.dart';
import 'package:hr/core/globals.dart';
import 'package:hr/utils/styles/styles.dart';

Future<bool?> showAreYouSureDialog() async {
  BuildContext? context = navigatorKey.currentContext;
  if (context == null) return null;
  final bool? result = await showDialog<bool>(
    context: context,
    builder: (contex) {
      return AlertDialog(
        title: txt('Warning', e: St.bold25, c: Colors.red),
        content: txt('Do You Want To Proceed?!', e: St.semi14, c: Colors.white),
        backgroundColor: context.primaryColor.withOpacity(0.8),
        actions: [
          TextButton(
            child: txt('Yes', e: St.reg14, c: Colors.white),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
          TextButton(
            child: txt('No', e: St.reg14, c: Colors.white),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        ],
      );
    },
  );
  return result;
}
