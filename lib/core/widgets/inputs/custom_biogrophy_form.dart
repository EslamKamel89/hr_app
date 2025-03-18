import 'package:flutter/material.dart';

class CustomBiographyForm extends StatelessWidget {
  const CustomBiographyForm({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        maxLines: 20,
        minLines: 2,
        decoration: InputDecoration(
          labelText: 'Biography',
          hintText: 'Write a brief biography',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
    );
  }
}
