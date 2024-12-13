import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color backgroundColorButton;
  final Color textColorButton;
  final Function()? onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.backgroundColorButton,
    required this.onPressed,
    required this.textColorButton,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 2,
        backgroundColor: backgroundColorButton,
        shape: StadiumBorder(),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColorButton,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
