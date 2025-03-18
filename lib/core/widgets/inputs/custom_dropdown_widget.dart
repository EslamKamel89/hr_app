import 'package:flutter/material.dart';
import 'package:hr/core/extensions/context-extensions.dart';
import 'package:hr/core/models/pass_by_reference.dart';
import 'package:hr/utils/styles/styles.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({
    super.key,
    required this.options,
    required this.label,
    required this.onSelect,
    this.req = true,
    this.initialValue,
    this.hint,
  });
  final List<String> options;
  final String label;
  final Function(String?) onSelect;
  final bool req;
  final String? initialValue;
  final String? hint;
  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String? selectedValue;
  @override
  void initState() {
    selectedValue = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              txt(widget.label, e: St.bold16),
              SizedBox(width: 5),
              txt(widget.req ? '*' : '(optinal)', e: St.reg12, c: widget.req ? Colors.red : null),
            ],
          ),
        ),
        DropdownButtonFormField(
          decoration: _decoration(widget.label),
          hint: widget.hint == null ? null : txt(widget.hint!),
          value: selectedValue,
          items:
              widget.options
                  .map((option) => DropdownMenuItem<String>(value: option, child: txt(option)))
                  .toList(),
          onChanged: (String? value) {
            widget.onSelect(value);
            setState(() {
              selectedValue = value;
            });
          },
          // validator: (value) => value == null ? 'Please Select A Value' : null,
        ),
      ],
    );
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      // labelText: label,
      labelStyle: context.inputDecorationTheme.labelStyle,
      hintStyle: context.inputDecorationTheme.hintStyle,
      border: context.inputDecorationTheme.border,
      enabledBorder: context.inputDecorationTheme.enabledBorder,
      focusedBorder: context.inputDecorationTheme.focusedBorder,
      contentPadding: context.inputDecorationTheme.contentPadding,
    );
  }
}

class DropDownWidget2 extends StatefulWidget {
  const DropDownWidget2({
    super.key,
    required this.options,
    required this.label,
    required this.onSelect,
    required this.value,
    this.req = true,
    this.hint,
  });
  final List<String> options;
  final String label;
  final Function(String?) onSelect;
  final bool req;
  final String? hint;
  final PassByReference<String?> value;
  @override
  State<DropDownWidget2> createState() => _DropDownWidget2State();
}

class _DropDownWidget2State extends State<DropDownWidget2> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              txt(widget.label, e: St.bold16),
              SizedBox(width: 5),
              txt(widget.req ? '*' : '(optinal)', e: St.reg12, c: widget.req ? Colors.red : null),
            ],
          ),
        ),
        DropdownButtonFormField<String>(
          decoration: _decoration(widget.label),
          hint: widget.hint == null ? null : txt(widget.hint!),
          value: widget.value.data,
          items:
              widget.options
                  .map((option) => DropdownMenuItem<String>(value: option, child: txt(option)))
                  .toList(),
          onChanged: (String? value) {
            widget.onSelect(value);
            setState(() {
              widget.value.data = value;
            });
          },
          // validator: (value) => value == null ? 'Please Select A Value' : null,
        ),
      ],
    );
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      // labelText: label,
      labelStyle: context.inputDecorationTheme.labelStyle,
      hintStyle: context.inputDecorationTheme.hintStyle,
      border: context.inputDecorationTheme.border,
      enabledBorder: context.inputDecorationTheme.enabledBorder,
      focusedBorder: context.inputDecorationTheme.focusedBorder,
      contentPadding: context.inputDecorationTheme.contentPadding,
    );
  }
}
