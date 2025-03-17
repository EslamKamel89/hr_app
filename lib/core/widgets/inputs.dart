import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hr/core/extensions/context-extensions.dart';
import 'package:hr/core/heleprs/pick_image.dart';
import 'package:hr/core/models/pass_by_reference.dart';
import 'package:hr/core/widgets/choose_camera_or_gallery.dart';
import 'package:hr/utils/styles/styles.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AuthTextFormField extends StatefulWidget {
  const AuthTextFormField({
    super.key,
    required this.labelText,
    required this.controller,
    this.prefixIcon,
    this.obscureText = false,
    this.validator,
    this.onChanged,
  });
  final String labelText;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  @override
  State<AuthTextFormField> createState() => _AuthTextFormFieldState();
}

class _AuthTextFormFieldState extends State<AuthTextFormField> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText && !showPassword,
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        labelText: widget.labelText,
        prefixIcon: Icon(widget.prefixIcon, color: context.primaryColorDark),
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
                        color: context.primaryColorDark,
                      ),
                    );
                  },
                )
                : null,
        border: context.inputDecorationTheme.border,
      ),
    );
  }
}

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
  State<CustomTextFormFieldWithSuggestions> createState() =>
      _CustomTextFormFieldWithSuggestionsState();
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
          final result =
              widget.suggestions
                  .where(
                    (String suggestion) =>
                        suggestion.toLowerCase().trim().contains(search.trim().toLowerCase()),
                  )
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

class TextAreaWidget extends StatelessWidget {
  const TextAreaWidget({super.key, required this.text, this.label = ''});
  final String text;
  final String label;
  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      textAlign: TextAlign.right,
      maxLines: null,
      decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      controller: TextEditingController(text: text),
    );
  }
}

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

class CustomTextField extends StatelessWidget {
  const CustomTextField(
    this.label,
    this.controller,
    this.hint, {
    super.key,
    this.inputType = TextInputType.text,
    this.validator,
    this.showMulitLine = false,
  });
  final String label;
  final TextEditingController controller;
  final String hint;
  final TextInputType inputType;
  final String? Function(String?)? validator;
  final bool showMulitLine;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        validator: validator,
        maxLines: showMulitLine ? 20 : null,
        minLines: showMulitLine ? 2 : null,
      ),
    );
  }
}

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({
    super.key,
    required this.options,
    required this.label,
    required this.onSelect,
    this.req = true,
    this.initialValue,
  });
  final List<String> options;
  final String label;
  final Function(String?) onSelect;
  final bool req;
  final String? initialValue;
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

class UploadFileWidget extends StatefulWidget {
  const UploadFileWidget({
    super.key,
    required this.label,
    required this.file,
    this.path,
    this.req = false,
  });
  final String label;
  final PassByReference<File?> file;
  final String? path;
  final bool req;
  @override
  State<UploadFileWidget> createState() => _UploadFileWidgetState();
}

class _UploadFileWidgetState extends State<UploadFileWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Flexible(child: txt(widget.label, e: St.bold18, softwrap: true)),
                  // SizedBox(width: 5),
                  // txt(widget.req ? '*' : '(optinal)', e: St.reg12, c: widget.req ? Colors.red : null),
                ],
              ),
            ),
            widget.file.data != null || widget.path != null
                ? Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                      clipBehavior: Clip.hardEdge,
                      child:
                          widget.file.data != null
                              ? Image.file(widget.file.data!, fit: BoxFit.cover)
                              : Image.network(widget.path!),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: InkWell(
                        onTap: _pickImage,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.7),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.edit, size: 30),
                        ),
                      ),
                    ),
                  ],
                )
                : InkWell(
                  onTap: _pickImage,
                  child: Container(
                    margin: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: context.primaryColor,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    child: txt('Upload', e: St.bold18, c: Colors.white),
                  ),
                ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  _pickImage() async {
    final ImageSource? imageSource = await chooseGalleryOrCameraDialog();
    if (imageSource == null) return;
    widget.file.data = await pickImage(imageSource);
    setState(() {});
  }
}
