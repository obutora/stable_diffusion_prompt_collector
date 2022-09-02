import 'package:flutter/material.dart';

ButtonStyle primaryButtonStyle() {
  return ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    backgroundColor: Colors.indigoAccent,
    foregroundColor: Colors.white,
  );
}

ButtonStyle menuButtonStyle() {
  return ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.white,
  );
}
