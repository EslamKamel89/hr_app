import 'package:flutter/material.dart';
import 'package:hr/core/widgets/inputs.dart';
import 'package:hr/core/widgets/save_button.dart';

class CompanyBasicForm extends StatefulWidget {
  const CompanyBasicForm({super.key});

  @override
  State<CompanyBasicForm> createState() => _CompanyBasicFormState();
}

class _CompanyBasicFormState extends State<CompanyBasicForm> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
          CustomTextFormField(
            label: 'Company Name',
            placeholder: 'Enter Company Name',
          ),
          SizedBox(height: 10),
          CustomTextFormField(
            label: 'Trade License No',
            placeholder: 'Enter Trade License No',
          ),
          SizedBox(height: 10),
          CustomTextFormField(
            label: 'Abbr',
            placeholder: 'Enter Abbr',
            req: false,
          ),
          SizedBox(height: 10),
          CustomDateField(
            label: 'Date of Incorporation',
            req: false,
            onDateSubmit: (data) {},
            initialDate: DateTime.now(),
            textEditingController: TextEditingController(),
            // placeholder: 'Enter Date of Incorporation',
          ),
          SizedBox(height: 10),
          CustomTextFormField(
            label: 'Website',
            placeholder: 'Enter Website',
            req: false,
          ),
          SizedBox(height: 10),
          DropDownWidget(
            label: 'Parent Company',
            options: [],
            onSelect: () {},
            req: false,
            // placeholder: 'Enter Parent Company',
          ),
          SizedBox(height: 10),
          CustomMultipleTextFormField(
            label: 'Business Activities',
            placeholder: 'Enter Business Activities',
            req: false,
            onSelected: (value) {},
            controller: TextEditingController(),
          ),
          SizedBox(height: 30),
          SaveButton(onTap: () {}),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
