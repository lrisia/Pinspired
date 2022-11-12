import 'package:cnc_shop/main.dart';
import 'package:flutter/material.dart';

void showSnackBar(String? text, {Color? backgroundColor}) {
  if (text == null) return;

  final snackBar = SnackBar(
    content: Text(
      text,
    ),
    backgroundColor: backgroundColor ?? Colors.red[900],
  );

  messageKey.currentState!
    ..removeCurrentSnackBar()
    ..showSnackBar(snackBar);
}
