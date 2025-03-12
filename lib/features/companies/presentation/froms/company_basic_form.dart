import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/heleprs/format_date.dart';
import 'package:hr/core/widgets/inputs.dart';
import 'package:hr/core/widgets/save_button.dart';
import 'package:hr/features/companies/cubits/company_form/company_form_cubit.dart';

class CompanyBasicForm extends StatefulWidget {
  const CompanyBasicForm({super.key});

  @override
  State<CompanyBasicForm> createState() => _CompanyBasicFormState();
}

class _CompanyBasicFormState extends State<CompanyBasicForm> {
  final TextEditingController companyName = TextEditingController();
  final TextEditingController tradeLicense = TextEditingController();
  final TextEditingController abbr = TextEditingController();
  final TextEditingController dateOfIncorporationStr = TextEditingController();
  DateTime? dateOfIncorporation;
  final TextEditingController website = TextEditingController();
  List<String> activities = [];
  late final CompanyFormCubit controller;
  @override
  void initState() {
    controller = context.read<CompanyFormCubit>();
    companyName.text = controller.state.company?.data?.companyName ?? '';
    tradeLicense.text =
        controller.state.company?.data?.tradeLicenseNumber ?? '';
    abbr.text = controller.state.company?.data?.abbr ?? '';
    website.text = controller.state.company?.data?.websiteUrl ?? '';
    super.initState();
  }

  @override
  void dispose() {
    companyName.dispose();
    tradeLicense.dispose();
    abbr.dispose();
    website.dispose();
    dateOfIncorporationStr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
          CustomTextFormField(
            label: 'Company Name',
            placeholder: 'Enter Company Name',
            controller: companyName,
          ),
          SizedBox(height: 10),
          CustomTextFormField(
            label: 'Trade License No',
            placeholder: 'Enter Trade License No',
            controller: tradeLicense,
          ),
          SizedBox(height: 10),
          CustomTextFormField(
            label: 'Abbr',
            placeholder: 'Enter Abbr',
            req: false,
            controller: abbr,
          ),
          SizedBox(height: 10),
          CustomDateField(
            label: 'Date of Incorporation',
            req: false,
            onDateSubmit: (data) {},
            initialDate: parseDateTime(
              controller.state.company?.data?.createdAt,
            ),
            textEditingController: dateOfIncorporationStr,
          ),
          SizedBox(height: 10),
          CustomTextFormField(
            label: 'Website',
            placeholder: 'Enter Website',
            req: false,
            controller: website,
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
            initialValues: controller.state.company?.data?.businessActivities
                ?.split(','),
          ),
          SizedBox(height: 30),
          SaveButton(onTap: () {}),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
