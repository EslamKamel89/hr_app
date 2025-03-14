import 'package:flutter/material.dart';
import 'package:hr/core/heleprs/validator.dart';
import 'package:hr/core/widgets/collapsible_card.dart';
import 'package:hr/core/widgets/inputs.dart';
import 'package:hr/core/widgets/save_button.dart';
import 'package:hr/features/companies/presentation/widgets/form_vertical_gap.dart';
import 'package:hr/utils/styles/styles.dart';

class AddSubDepartment extends StatelessWidget {
  const AddSubDepartment({super.key});

  @override
  Widget build(BuildContext context) {
    return CollapsibleCard(
      header: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [txt('Add Sub Department'), Icon(Icons.add)],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
    );
  }
}
