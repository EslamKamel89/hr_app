import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/heleprs/validator.dart';
import 'package:hr/core/widgets/inputs.dart';
import 'package:hr/features/companies/cubits/company_form/company_form_cubit.dart';
import 'package:hr/features/companies/presentation/widgets/form_vertical_gap.dart';
import 'package:hr/features/companies/presentation/widgets/section_title.dart';

class CompanyContactForm extends StatefulWidget {
  const CompanyContactForm({super.key});

  @override
  State<CompanyContactForm> createState() => _CompanyContactFormState();
}

class _CompanyContactFormState extends State<CompanyContactForm> {
  final TextEditingController _contactName = TextEditingController();
  final TextEditingController _companyEmail = TextEditingController();
  final TextEditingController _primaryMobileNumber = TextEditingController();
  final TextEditingController _secondaryMobileNumber = TextEditingController();
  final TextEditingController _landlineNumber = TextEditingController();
  final TextEditingController _faxNumber = TextEditingController();
  final TextEditingController _hrMobileNumber = TextEditingController();
  final TextEditingController _hrLandlineNumber = TextEditingController();
  final TextEditingController _hrEmail = TextEditingController();
  late final CompanyFormCubit _controller;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _controller = context.read<CompanyFormCubit>();
    _initializeFields();
    super.initState();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            SectionTitle(title: 'Primary Contact Details'),
            FormVerticalGap(),
            CustomTextFormField(
              label: 'Company Name',
              placeholder: 'Enter Company Name',
              controller: _contactName,
              validator:
                  (input) => valdiator(
                    input: input,
                    label: 'Contact Name',
                    isRequired: true,
                    minChars: 5,
                    maxChars: 50,
                  ),
            ),
            FormVerticalGap(),
            CustomTextFormField(
              label: 'Company Email',
              placeholder: 'Enter Company Email',
              controller: _companyEmail,
              validator:
                  (input) => valdiator(
                    input: input,
                    label: 'Company Email',
                    isRequired: true,
                    minChars: 5,
                    maxChars: 50,
                  ),
            ),
            FormVerticalGap(),
            CustomTextFormField(
              label: 'Primary Mobile Number',
              placeholder: 'Enter Primary Mobile Number',
              controller: _contactName,
              validator:
                  (input) => valdiator(
                    input: input,
                    label: 'Primary Mobile Number',
                    isRequired: true,
                    minChars: 5,
                    maxChars: 50,
                  ),
            ),
            FormVerticalGap(),
            CustomTextFormField(
              label: 'Secondary Mobile Number',
              placeholder: 'Enter Secondary Mobile Number',
              controller: _contactName,
              validator:
                  (input) => valdiator(
                    input: input,
                    label: 'Secondary Mobile Number',
                    isRequired: true,
                    minChars: 5,
                    maxChars: 50,
                  ),
            ),
            FormVerticalGap(),
            CustomTextFormField(
              label: 'Landline Number',
              placeholder: 'Enter Landline Number',
              controller: _contactName,
              validator:
                  (input) => valdiator(
                    input: input,
                    label: 'Landline Number',
                    isRequired: true,
                    minChars: 5,
                    maxChars: 50,
                  ),
            ),
            FormVerticalGap(),
            CustomTextFormField(
              label: 'Fax Number',
              placeholder: 'Enter Fax Number',
              controller: _contactName,
              validator:
                  (input) => valdiator(
                    input: input,
                    label: 'Fax Number',
                    isRequired: true,
                    minChars: 5,
                    maxChars: 50,
                  ),
            ),
            FormVerticalGap(),
            SectionTitle(title: 'HR Contact Details'),
            FormVerticalGap(),
            CustomTextFormField(
              label: 'Mobile Number:',
              placeholder: 'Enter Mobile Number:',
              controller: _contactName,
              validator:
                  (input) => valdiator(
                    input: input,
                    label: 'Mobile Number:',
                    isRequired: true,
                    minChars: 5,
                    maxChars: 50,
                  ),
            ),
            FormVerticalGap(),
            CustomTextFormField(
              label: 'Landline Number',
              placeholder: 'Enter Landline Number',
              controller: _contactName,
              validator:
                  (input) => valdiator(
                    input: input,
                    label: 'Landline Number',
                    isRequired: true,
                    minChars: 5,
                    maxChars: 50,
                  ),
            ),
            FormVerticalGap(),
            CustomTextFormField(
              label: 'Email',
              placeholder: 'Enter Email',
              controller: _contactName,
              validator:
                  (input) => valdiator(
                    input: input,
                    label: 'Email',
                    isRequired: true,
                    minChars: 5,
                    maxChars: 50,
                  ),
            ),
            FormVerticalGap(),
          ],
        ),
      ),
    );
  }

  void _initializeFields() {
    _contactName.text = _controller.state.contact?.data?.contactName ?? '';
    _companyEmail.text = _controller.state.contact?.data?.companyEmail ?? '';
    _primaryMobileNumber.text = _controller.state.contact?.data?.primaryMobileNumber ?? '';
    _landlineNumber.text = _controller.state.contact?.data?.landlineNumber ?? '';
    _faxNumber.text = _controller.state.contact?.data?.faxNumber ?? '';
    _hrMobileNumber.text = _controller.state.contact?.data?.hrMobileNumber ?? '';
    _hrLandlineNumber.text = _controller.state.contact?.data?.hrLandlineNumber ?? '';
    _hrEmail.text = _controller.state.contact?.data?.hrEmail ?? '';
  }

  void _disposeControllers() {
    _contactName.dispose();
    _companyEmail.dispose();
    _primaryMobileNumber.dispose();
    _secondaryMobileNumber.dispose();
    _faxNumber.dispose();
    _hrMobileNumber.dispose();
    _hrLandlineNumber.dispose();
    _hrEmail.dispose();
  }

  Future _sendRequest() async {
    if (_formKey.currentState!.validate()) {}
  }
}
