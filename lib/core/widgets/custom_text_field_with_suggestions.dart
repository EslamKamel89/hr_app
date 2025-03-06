
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class CustomTextFormFieldWithSuggestions extends StatefulWidget {
  const CustomTextFormFieldWithSuggestions({
    super.key,
    required this.label,
    required this.suggestions,
    required this.onSelected,
    required this.controller,
  });
  final List<String> suggestions;
  final String label;
  final Function(String) onSelected;
  final TextEditingController controller;
  @override
  State<CustomTextFormFieldWithSuggestions> createState() => _CustomTextFormFieldWithSuggestionsState();
}

class _CustomTextFormFieldWithSuggestionsState extends State<CustomTextFormFieldWithSuggestions> {
  String selectedValue = '';
  @override
  void initState() {
    selectedValue = widget.controller.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.controller.text = selectedValue;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TypeAheadField<String>(
        controller: widget.controller,
        suggestionsCallback: (search) {
          final result = widget.suggestions
              .where((String suggestion) => suggestion.toLowerCase().trim().contains(search.trim().toLowerCase()))
              .toList();
          return result;
        },
        builder: (context, controller, focusNode) {
          // controller.text = selectedValue;
          return TextField(
            controller: controller,
            focusNode: focusNode,
            // autofocus: true,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: widget.label,
            ),
            // onChanged: ,
          );
        },
        itemBuilder: (context, option) {
          return ListTile(
            title: Text(option),
            // subtitle: Text(city.country),
          );
        },
        onSelected: (String option) {
          widget.onSelected(option);
          setState(() {
            selectedValue = option;
          });
        },
      ),
    );
  }
}
