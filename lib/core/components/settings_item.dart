
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:welfare_fund_admin/core/constants/palette.dart';
import 'package:welfare_fund_admin/features/auth/providers/sign_provider.dart';
import 'package:welfare_fund_admin/features/settings/providers/theme_provider.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({
    super.key,
    required this.label,
    required this.children,
  });

  final String label;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Palette.textColor2,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Consumer<ThemeProvider>(
          builder: (_, ref, __) {
            return Container(
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: ref.isDarkMode || ref.isDarkTheme
                    ? Colors.grey.shade800
                    : Colors.white,
              ),
              child: Column(
                children: children,
              ),
            );
          },
        )
      ],
    );
  }
}

class SettingsListItem extends StatefulWidget {
  const SettingsListItem(
      {super.key,
      this.onTap,
      this.icon,
      required this.label,
      this.toggle = false,
      this.bgColor = Colors.white,
      this.child,
      this.txtColor = const Color.fromARGB(255, 165, 119, 238),
      this.animatedIcon});

  final void Function()? onTap;
  final String label;
  final IconData? icon;
  final Widget? child;
  final bool toggle;
  final Color? bgColor;
  final Color? txtColor;
  final Widget? animatedIcon;
  @override
  State<SettingsListItem> createState() => _SettingsListItemState();
}

class _SettingsListItemState extends State<SettingsListItem> {
  bool isActive = false;

  void change(bool value) {
    setState(() {
      isActive = value;
    });
    // if (widget.onTap != null) {
    //   widget.onTap!();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.toggle) {
          change(!isActive);
        } else {
          if (widget.onTap != null) {
            widget.onTap!();
          }
        }
      },
      child: Consumer<ThemeProvider>(
        builder: (_, ref, __) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ref.isDarkMode || ref.isDarkTheme
                  ? Colors.grey.shade900.withOpacity(0.78)
                  : widget.bgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                widget.toggle == true
                    ? widget.child!
                    : Icon(widget.icon,
                        color: widget.txtColor ??
                            Theme.of(context).colorScheme.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(widget.label,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Palette.textColor1)),
                ),
                widget.toggle == true
                    ? Switch(
                        value: ref.isDarkTheme ? true : ref.isDarkMode,
                        inactiveThumbColor: Palette.textColor1,
                        inactiveTrackColor: Colors.white,
                        activeColor: Theme.of(context).colorScheme.primary,
                        onChanged: (value) {
                          ref.toggleThemeMode();
                          // if(ref.isDarkMode || ref.isDarkTheme){
                          //   context.read<SignInProvider>().setSignIn(true);
                          // }else{
                          //   context.read<SignInProvider>().setSignIn(false);
                          // }
                        },
                      )
                    : Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: widget.txtColor ??
                            Theme.of(context).colorScheme.primary,
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
