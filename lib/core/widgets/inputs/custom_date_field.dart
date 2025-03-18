import 'package:flutter/material.dart';
import 'package:hr/utils/styles/styles.dart';

class CustomDateField extends StatefulWidget {
  const CustomDateField({
    super.key,
    required this.onDateSubmit,
    required this.label,
    required this.initialDate,
    required this.textEditingController,
    this.validator,
    this.req = true,
  });
  final String label;
  final DateTime? initialDate;
  final Function(DateTime date) onDateSubmit;
  final String? Function(String?)? validator;
  final TextEditingController textEditingController;
  final bool req;

  @override
  State<CustomDateField> createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  // final dateEditingController = TextEditingController();
  DateTime? selectedDate;
  @override
  void initState() {
    selectedDate = widget.initialDate;
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
        GestureDetector(
          onTap: () => _selectDate(context),
          child: AbsorbPointer(
            child: TextFormField(
              controller: widget.textEditingController,
              decoration: InputDecoration(
                // labelText: widget.label,
                hintText:
                    widget.initialDate != null
                        ? '${widget.initialDate?.year}-${widget.initialDate?.month.toString().padLeft(2, '0')}-${widget.initialDate?.day.toString().padLeft(2, '0')}'
                        : 'Select a date',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
              // validator: (_) => widget.selectedDate == null ? '${widget.label} is required' : null,
              validator: widget.validator,
            ),
          ),
        ),
      ],
    );
  }

  // Method to pick a date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        widget.onDateSubmit(pickedDate);
        widget.textEditingController.text =
            '${selectedDate?.year}-${selectedDate?.month.toString().padLeft(2, '0')}-${selectedDate?.day.toString().padLeft(2, '0')}';
      });
    }
  }
}
