import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/heleprs/validator.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/widgets/inputs.dart';
import 'package:hr/core/widgets/save_button.dart';
import 'package:hr/features/companies/cubits/company_contact_cubit.dart';
import 'package:hr/features/companies/cubits/company_form/company_form_cubit.dart';
import 'package:hr/features/companies/helpers/get_company.dart';
import 'package:hr/features/companies/models/company_contact_model.dart';
import 'package:hr/features/companies/presentation/widgets/form_vertical_gap.dart';
import 'package:hr/features/companies/presentation/widgets/section_title.dart';

class CompanyContactProvider extends StatelessWidget {
  const CompanyContactProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompanyContactCubit(),
      child: const CompanyContactForm(),
    );
  }
}

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
  late final CompanyContactCubit _controller;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _controller = context.read<CompanyContactCubit>();
    _controller.contactShow(context);
    super.initState();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyFormCubit, CompanyFormState>(
      buildWhen: (previous, current) {
        return (previous.currentTab != 1 && current.currentTab == 1);
      },
      builder: (context, state) {
        if (getCompany(context) == null) {
          return Center(
            child: Text("Please Fill Your Basic Data First", style: TextStyle(fontSize: 20)),
          );
        }
        return BlocBuilder<CompanyContactCubit, ApiCrudResponseModel<CompanyContactModel>>(
          buildWhen: (previous, current) {
            return (previous.showResponse != ResponseEnum.success &&
                current.showResponse == ResponseEnum.success);
          },
          builder: (context, state) {
            _initializeFields();
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
                            isEmail: true,
                            minChars: 5,
                            maxChars: 50,
                          ),
                    ),
                    FormVerticalGap(),
                    CustomTextFormField(
                      label: 'Primary Mobile Number',
                      placeholder: 'Enter Primary Mobile Number',
                      controller: _primaryMobileNumber,
                      showNumberOnly: true,
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
                      controller: _secondaryMobileNumber,
                      showNumberOnly: true,
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
                      controller: _landlineNumber,
                      showNumberOnly: true,
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
                      controller: _faxNumber,
                      showNumberOnly: true,
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
                      showNumberOnly: true,
                      controller: _hrMobileNumber,
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
                      showNumberOnly: true,
                      controller: _hrLandlineNumber,
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
                      controller: _hrEmail,
                      validator:
                          (input) => valdiator(
                            input: input,
                            label: 'Email',
                            isRequired: true,
                            isEmail: true,
                            minChars: 5,
                            maxChars: 50,
                          ),
                    ),
                    SizedBox(height: 30),
                    BlocBuilder<CompanyContactCubit, ApiCrudResponseModel<CompanyContactModel>>(
                      // buildWhen:
                      //     (previous, current) => [
                      //       ResponseEnum.loading,
                      //       ResponseEnum.success,
                      //     ].contains(current.contact?.response),
                      builder: (context, state) {
                        if (state.showResponse == ResponseEnum.loading ||
                            state.upsertResponse == ResponseEnum.loading) {
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
          },
        );
      },
    );
  }

  void _initializeFields() {
    _contactName.text = _controller.state.data?.contactName ?? '';
    _companyEmail.text = _controller.state.data?.companyEmail ?? '';
    _primaryMobileNumber.text = _controller.state.data?.primaryMobileNumber ?? '';
    _secondaryMobileNumber.text = _controller.state.data?.secondaryMobileNumber ?? '';
    _landlineNumber.text = _controller.state.data?.landlineNumber ?? '';
    _faxNumber.text = _controller.state.data?.faxNumber ?? '';
    _hrMobileNumber.text = _controller.state.data?.hrMobileNumber ?? '';
    _hrLandlineNumber.text = _controller.state.data?.hrLandlineNumber ?? '';
    _hrEmail.text = _controller.state.data?.hrEmail ?? '';
  }

  void _disposeControllers() {
    _contactName.dispose();
    _companyEmail.dispose();
    _primaryMobileNumber.dispose();
    _secondaryMobileNumber.dispose();
    _landlineNumber.dispose();
    _faxNumber.dispose();
    _hrMobileNumber.dispose();
    _hrLandlineNumber.dispose();
    _hrEmail.dispose();
  }

  Future _sendRequest() async {
    if (_formKey.currentState!.validate()) {
      _controller.contactUpsert(
        context,
        CompanyContactModel(
          contactName: _contactName.text,
          companyEmail: _companyEmail.text,
          primaryMobileNumber: _primaryMobileNumber.text,
          secondaryMobileNumber: _secondaryMobileNumber.text,
          landlineNumber: _landlineNumber.text,
          faxNumber: _faxNumber.text,
          hrMobileNumber: _hrMobileNumber.text,
          hrLandlineNumber: _hrLandlineNumber.text,
          hrEmail: _hrEmail.text,
        ),
      );
    }
  }
}
