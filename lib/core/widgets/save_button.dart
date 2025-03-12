import 'package:flutter/material.dart';
import 'package:hr/utils/styles/styles.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        child: txt('Save', e: St.bold18),
      ),
    );
  }
}
