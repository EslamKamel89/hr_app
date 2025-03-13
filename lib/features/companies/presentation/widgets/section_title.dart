import 'package:flutter/material.dart';
import 'package:hr/core/extensions/context-extensions.dart';
import 'package:hr/utils/styles/styles.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: EdgeInsets.only(top: 10),
      // alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: txt(title, e: St.bold18, c: Colors.white),
    );
  }
}
