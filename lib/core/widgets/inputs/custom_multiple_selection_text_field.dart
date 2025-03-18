import 'package:flutter/material.dart';
import 'package:hr/core/models/pass_by_reference.dart';
import 'package:hr/core/widgets/inputs/custom_text_form_field.dart';
import 'package:hr/utils/styles/styles.dart';

class CustomMultipleTextFormField extends StatefulWidget {
  const CustomMultipleTextFormField({
    super.key,
    required this.label,
    required this.onSelected,
    this.placeholder,
    this.req = true,
    this.initialValues,
    required this.valueByReference,
  });
  final String? placeholder;
  final String label;
  final Function(String) onSelected;
  final bool req;
  final List<String>? initialValues;
  final PassByReference<String?> valueByReference;
  @override
  State<CustomMultipleTextFormField> createState() => _CustomMultipleTextFormFieldState();
}

class _CustomMultipleTextFormFieldState extends State<CustomMultipleTextFormField> {
  List<String> inputs = [];
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    if (widget.initialValues != null) {
      inputs = widget.initialValues!;
    }
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFormField(
          controller: controller,
          placeholder: widget.placeholder,
          label: widget.label,
          req: widget.req,
          onSaveCallback: () {
            setState(() {
              inputs.add(controller.value.text);
              controller.text = '';
            });
            widget.valueByReference.data = inputs.join(',');
          },
        ),
        SizedBox(height: 5),
        ...List.generate(inputs.length, (index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              children: [
                Expanded(child: txt(inputs[index], e: St.reg14)),
                InkWell(
                  child: Icon(Icons.remove, color: Colors.red),
                  onTap: () {
                    setState(() {
                      inputs = inputs.where((input) => input != inputs[index]).toList();
                    });
                    widget.valueByReference.data = inputs.join(',');
                  },
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
