import 'package:flutter/material.dart';
import 'package:hr/core/extensions/context-extensions.dart';
import 'package:hr/utils/styles/styles.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.placeholder,
    this.label,
    this.prefixIcon,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.req = true,
    this.onSaveCallback,
    this.showNumberOnly = false,
  });
  final String? placeholder;
  final String? label;
  final Widget? prefixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool req;
  final VoidCallback? onSaveCallback;
  final bool showNumberOnly;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null)
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                txt(widget.label!, e: St.bold16),
                SizedBox(width: 5),
                txt(widget.req ? '*' : '(optinal)', e: St.reg12, c: widget.req ? Colors.red : null),
              ],
            ),
          ),

        TextFormField(
          obscureText: widget.obscureText && !showPassword,
          controller: widget.controller,
          validator: widget.validator,
          onChanged: widget.onChanged,
          keyboardType: widget.showNumberOnly ? TextInputType.phone : null,
          decoration: InputDecoration(
            hintText: widget.placeholder,
            prefixIcon: widget.prefixIcon,
            suffixIcon:
                widget.obscureText
                    ? Builder(
                      builder: (context) {
                        return IconButton(
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          icon: Icon(
                            showPassword ? MdiIcons.eyeOffOutline : MdiIcons.eyeOutline,
                            color: context.primaryColor,
                          ),
                        );
                      },
                    )
                    : widget.onSaveCallback != null
                    ? InkWell(
                      onTap: widget.onSaveCallback,
                      child: Icon(Icons.save, color: context.primaryColor),
                    )
                    : null,
            border: context.inputDecorationTheme.border,
          ),
        ),
      ],
    );
  }
}
