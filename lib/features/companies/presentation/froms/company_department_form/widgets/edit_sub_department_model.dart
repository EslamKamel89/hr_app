import 'package:flutter/material.dart';
import 'package:hr/core/heleprs/validator.dart';
import 'package:hr/core/widgets/inputs.dart';
import 'package:hr/core/widgets/save_button.dart';
import 'package:hr/features/companies/presentation/widgets/form_vertical_gap.dart';
import 'package:hr/utils/styles/styles.dart';

class EditSubDepartmentModel extends StatefulWidget {
  const EditSubDepartmentModel({super.key});

  @override
  State<EditSubDepartmentModel> createState() => _EditSubDepartmentModelState();
}

class _EditSubDepartmentModelState extends State<EditSubDepartmentModel> {
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
                txt('Edit Sub Department', e: St.bold20),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.close),
                ),
              ],
            ),
            FormVerticalGap(),
            DropDownWidget(
              label: 'Pick Main Category',
              initialValue: 'category 1',
              options: ['category 1', 'category 2', 'category 3', 'category 4'],
              onSelect: (value) {},
            ),
            FormVerticalGap(),
            CustomTextFormField(
              placeholder: 'Enter Sub Department',
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
