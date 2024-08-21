import 'package:church_clique/core/constants/palette.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';

class DateTimePickerWidget extends StatelessWidget {
  const DateTimePickerWidget({
    super.key,
    this.onPressed,
    required this.hintText,
    required this.controller,
    this.validator,
    this.onSaved
  });

  final void Function()? onPressed;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.67,
          child: TextFormField(
            onSaved: onSaved,
            validator: validator ,
            readOnly: true,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Palette.textColor1,
              ),
              contentPadding: const EdgeInsets.all(13),
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35),
                borderSide: const BorderSide(color: Palette.textColor1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35),
                borderSide: const BorderSide(color: Palette.textColor2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35),
                borderSide: const BorderSide(color: Palette.textColor1),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 22),
          child: IconButton(
            tooltip: "select Date",
            onPressed: onPressed,
            icon: const Icon(
              MaterialCommunityIcons.calendar,
              color: Palette.textColor1,
              size: 25,
            ),
          ),
        )
      ],
    );
  }
}
