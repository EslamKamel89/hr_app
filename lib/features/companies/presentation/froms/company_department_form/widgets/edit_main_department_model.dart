import 'package:flutter/material.dart';
import 'package:hr/core/heleprs/validator.dart';
import 'package:hr/core/widgets/inputs.dart';
import 'package:hr/core/widgets/save_button.dart';
import 'package:hr/features/companies/presentation/widgets/form_vertical_gap.dart';
import 'package:hr/utils/styles/styles.dart';

class EditMainDepartmentModel extends StatefulWidget {
  const EditMainDepartmentModel({super.key});

  @override
  State<EditMainDepartmentModel> createState() =>
      _EditMainDepartmentModelState();
}

class _EditMainDepartmentModelState extends State<EditMainDepartmentModel> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                txt('Edit Main Department', e: St.bold20),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.close),
                ),
              ],
            ),
            FormVerticalGap(),
            CustomTextFormField(
              placeholder: 'Enter Main Department',
              // controller: _contactName,
              validator:
                  (input) => valdiator(
                    input: input,
                    label: 'Main Department',
                    isRequired: true,
                    minChars: 5,
                    maxChars: 50,
                  ),
            ),
            FormVerticalGap(),
            SaveButton(onTap: () {}, title: 'Create'),
            FormVerticalGap(),
          ],
        ),
      ),
    );
  }
}
