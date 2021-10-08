import 'package:flutter/material.dart';

class BackButtons extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;

  const BackButtons({Key? key, required this.onPressed, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10, bottom: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: Colors.black,
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
