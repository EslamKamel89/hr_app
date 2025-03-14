import 'package:flutter/material.dart';
import 'package:hr/utils/styles/styles.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key, required this.onTap, this.title});
  final VoidCallback onTap;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        child: txt(title ?? 'Save', e: St.bold18),
      ),
    );
  }
}
