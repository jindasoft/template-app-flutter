import 'package:flutter/material.dart';

void nextScreen(BuildContext context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenPopup(BuildContext context, page) => Navigator.push(
  context,
  MaterialPageRoute(fullscreenDialog: true, builder: (context) => page),
);

void nextScreenCloseOthers(BuildContext context, page) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => page),
    (route) => false,
  );
}

void nextScreenReplace(BuildContext context, page) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}
