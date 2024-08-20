import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.isShadow,
    this.onTap,
    this.isSending,
  });
  final bool isShadow;
  final void Function()? onTap;
  final bool? isSending;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top:  430,
      right: 0,
      left: 0,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 700),
          curve: Curves.bounceInOut,
          width: 90,
          height: 90,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
            boxShadow: [
              if (isShadow)
                BoxShadow(
                  spreadRadius: 1.5,
                  blurRadius: 15,
                  color: Colors.black.withOpacity(0.3),
                ),
            ],
          ),
          child: !isShadow
              ? InkWell(
                  onTap: onTap,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.6),
                            Theme.of(context).colorScheme.primary,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 1,
                            blurRadius: 2,
                            color: Colors.black.withOpacity(0.3),
                          )
                        ]),
                    child: !isSending!
                        ? const SizedBox( 
                          // height:12,
                          // width: 12,
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: CircularProgressIndicator(color: Colors.white,),
                            ),
                            
                          )
                        : const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                  ),
                )
              : const Center(),
        ),
      ),
    );
  }
}
