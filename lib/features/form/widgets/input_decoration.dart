
import 'package:flutter/material.dart';
import 'package:welfare_fund_admin/core/constants/palette.dart';

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