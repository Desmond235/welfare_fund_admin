
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:welfare_fund_admin/core/constants/palette.dart';
import 'package:welfare_fund_admin/features/settings/providers/theme_provider.dart';

class BuildTextInput extends StatefulWidget {
  const BuildTextInput({
    super.key,
    this.icon,
    this.isEmail,
    required this.hintText,
    this.validator,
    this.type,
    this.controller,
    this.maxLength,
    this.onSaved,
    this.onChanged,
    this.textInputAction,
    this.maxLines,
  });

  final bool? isEmail;
  final IconData? icon;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final TextInputType? type;
  final TextEditingController? controller;
  final int? maxLength;
  final int? maxLines;
  final void Function(String? value)? onSaved;
  final void Function(String value)? onChanged;
  final TextInputAction? textInputAction;

  @override
  State<BuildTextInput> createState() => _BuildTextInputState();
}

class _BuildTextInputState extends State<BuildTextInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        maxLines: widget.maxLines,
        onChanged: widget.onChanged,
        controller: widget.controller,
        textInputAction: widget.textInputAction,
        autocorrect: false,
        inputFormatters: [
          // if(widget.type == TextInputType.text)
          // FilteringTextInputFormatter.allow(RegExp(r'\w( )?')),
          // FilteringTextInputFormatter.deny(RegExp(r'\d')),
          if (widget.type == TextInputType.phone)
            FilteringTextInputFormatter.allow(RegExp(r'\d')),
          LengthLimitingTextInputFormatter(
              widget.type == TextInputType.phone ? 10 : widget.maxLength),
        ],
        style: TextStyle(
            color:
                Provider.of<ThemeProvider>(context, listen: false).isDarkMode ||
                        Provider.of<ThemeProvider>(context, listen: false)
                            .isDarkTheme
                    ? Colors.white
                    : Colors.black),
        validator: widget.validator,
        maxLength: widget.maxLength,
        onSaved: widget.onSaved,
        keyboardType: widget.isEmail == true
            ? TextInputType.emailAddress
            : TextInputType.text,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          prefixIcon: Icon(
            widget.icon,
            color: Palette.iconColor,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(35),
              borderSide: const BorderSide(color: Palette.textColor1)),
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Palette.textColor1),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: const BorderSide(color: Palette.textColor1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: const BorderSide(color: Palette.textColor1),
          ),
        ),
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
      ),
    );
  }
}
