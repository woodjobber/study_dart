import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.onClicked,
    required this.text,
  });
  final VoidCallback onClicked;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClicked,
      style: ElevatedButton.styleFrom(
        maximumSize: Size.fromHeight(50),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
