import 'package:flutter/material.dart';
import 'package:hr/core/widgets/inputs/search_widget.dart';

class SearchableDropdownWidget extends StatefulWidget {
  const SearchableDropdownWidget({
    super.key,
    required this.options,
    required this.handleSelectOption,
    required this.label,
    required this.hintText,
    required this.isRequired,
  });
  final List<String> options;
  final Function handleSelectOption;
  final String label;
  final String hintText;
  final bool isRequired;
  @override
  State<SearchableDropdownWidget> createState() => _SearchableDropdownWidgetState();
}

class _SearchableDropdownWidgetState extends State<SearchableDropdownWidget> {
  String? selectedOption;
  void _showSearchDialog() async {
    String? result = await showDialog(
      context: context,
      builder: (context) {
        return SearchDialog(
          options: widget.options,
          initialValue: selectedOption,
          hintText: widget.hintText,
          label: widget.label,
        );
      },
    );
    if (result != null) {
      setState(() {
        selectedOption = result;
      });
      widget.handleSelectOption(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: const Icon(Icons.arrow_drop_down),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onTap: _showSearchDialog,
      controller: TextEditingController(text: selectedOption),
      validator: (value) {
        if (!widget.isRequired) {
          return null;
        }
        if (value == null || value.isEmpty) {
          return "Please select an option";
        }
        return null;
      },
    );
  }
}
