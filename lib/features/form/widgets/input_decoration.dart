import 'package:church_clique/core/constants/palette.dart';
import 'package:flutter/material.dart';

InputDecoration inputDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(10),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Palette.textColor1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Palette.textColor1),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Palette.textColor1),
      ),
    );
  }