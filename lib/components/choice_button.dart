import 'package:flutter/material.dart';

class ChoiceButton extends StatelessWidget {
  final String choice;
  final Function onPressed;

  const ChoiceButton({super.key, required this.choice, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ElevatedButton(
        onPressed: onPressed as void Function()?,
        child: Text(choice),
      ),
    );
  }
}