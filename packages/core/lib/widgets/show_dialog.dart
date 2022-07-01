
import 'package:flutter/material.dart';

Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
  context: context,
  builder: (context) => AlertDialog(
    title: Text('Do you want to Exit app'),
    actions: [
      ElevatedButton(onPressed: () => Navigator.pop(context, false), child: Text('No')),
      ElevatedButton(onPressed: () => Navigator.pop(context, true), child: Text('Yes'))
    ],
  )
);