import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/heleprs/format_date.dart';
import 'package:hr/core/heleprs/validator.dart';
import 'package:hr/core/models/pass_by_reference.dart';
import 'package:hr/core/widgets/inputs.dart';
import 'package:hr/core/widgets/save_button.dart';
import 'package:hr/features/companies/cubits/company_form/company_form_cubit.dart';
import 'package:hr/features/companies/models/company_model.dart';

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
  late final CompanyFormCubit controller;
  final PassByReference<String?> activities = PassByReference(null);
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    controller = context.read<CompanyFormCubit>();
    companyName.text = controller.state.company?.data?.companyName ?? '';
    tradeLicense.text =
        controller.state.company?.data?.tradeLicenseNumber ?? '';
    abbr.text = controller.state.company?.data?.abbr ?? '';
    website.text = controller.state.company?.data?.websiteUrl ?? '';
    dateOfIncorporation = parseDateTime(
      controller.state.company?.data?.incoporationDate,
    );
    activities.data = controller.state.company?.data?.businessActivities;
    super.initState();
  }

  @override
  void dispose() {
    companyName.dispose();
    tradeLicense.dispose();
    abbr.dispose();
    dateOfIncorporationStr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            CustomTextFormField(
              label: 'Company Name',
              placeholder: 'Enter Company Name',
              controller: companyName,
              validator:
                  (input) => valdiator(
                    input: input,
                    label: 'Company Name',
                    isRequired: true,
                    minChars: 5,
                    maxChars: 50,
                  ),
            ),
            SizedBox(height: 10),
            CustomTextFormField(
              label: 'Trade License No',
              placeholder: 'Enter Trade License No',
              controller: tradeLicense,
              validator:
                  (input) => valdiator(
                    input: input,
                    label: 'Trade License No',
                    isRequired: true,
                    minChars: 5,
                    maxChars: 50,
                  ),
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
              onDateSubmit: (date) {
                dateOfIncorporation = date;
              },
              initialDate: parseDateTime(
                controller.state.company?.data?.incoporationDate,
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
              options: ['Option one', 'Option two', 'Option three'],
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
              initialValues: activities.data?.split(','),
              valueByReference: activities,
            ),
            SizedBox(height: 30),
            BlocBuilder<CompanyFormCubit, CompanyFormState>(
              buildWhen:
                  (previous, current) => [
                    ResponseEnum.loading,
                    ResponseEnum.success,
                  ].contains(current.company?.response),
              builder: (context, state) {
                if (state.company?.response == ResponseEnum.loading) {
                  return Center(child: CircularProgressIndicator());
                }
                return SaveButton(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    _sendRequest();
                  },
                );
              },
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Future _sendRequest() async {
    if (_formKey.currentState!.validate()) {
      CompanyModel companyInState =
          controller.state.company?.data ?? CompanyModel();
      CompanyModel companyUpdated = companyInState.copyWith(
        companyName: companyName.text,
        tradeLicenseNumber: tradeLicense.text,
        abbr: abbr.text,
        incoporationDate: dateOfIncorporation?.toIso8601String(),
        websiteUrl: website.text,
        businessActivities: activities.data,
      );
      controller.state.company!.data = companyUpdated;
      await controller.basic();
    }
  }
}
