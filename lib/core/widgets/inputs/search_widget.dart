import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr/core/widgets/inputs/custom_text_form_field.dart';
import 'package:hr/utils/styles/styles.dart';

class SearchDialog extends StatefulWidget {
  const SearchDialog({
    super.key,
    required this.options,
    this.initialValue,
    required this.label,
    required this.hintText,
  });
  final List<String> options;
  final String? initialValue;
  final String label;
  final String hintText;
  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  late List<String> filteredOptions;
  late TextEditingController searchController;
  @override
  void initState() {
    super.initState();
    filteredOptions = widget.options;
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _filterOptions(String query) {
    setState(() {
      filteredOptions =
          widget.options
              .where((option) => option.trim().toLowerCase().contains(query.trim().toLowerCase()))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500.h,
      child: AlertDialog(
        title: txt('Search And Select ${widget.label}'),
        content: SizedBox(
          height: 500.h,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFormField(
                  placeholder: 'Search',
                  controller: searchController,
                  prefixIcon: const Icon(Icons.search),
                  onChanged: _filterOptions,
                ),
                const SizedBox(height: 10),
                ...List.generate(filteredOptions.length, (index) {
                  return ListTile(
                    title: txt(filteredOptions[index]),
                    onTap: () {
                      Navigator.of(context).pop(filteredOptions[index]);
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
