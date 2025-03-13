import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/heleprs/format_date.dart';
import 'package:hr/core/heleprs/validator.dart';
import 'package:hr/core/models/pass_by_reference.dart';
import 'package:hr/core/widgets/inputs.dart';
import 'package:hr/core/widgets/save_button.dart';
import 'package:hr/features/companies/cubits/companies_index_cubit.dart';
import 'package:hr/features/companies/cubits/company_form/company_form_cubit.dart';
import 'package:hr/features/companies/models/company_model.dart';

class CompanyBasicForm extends StatefulWidget {
  const CompanyBasicForm({super.key});
  @override
  State<CompanyBasicForm> createState() => _CompanyBasicFormState();
}

class _CompanyBasicFormState extends State<CompanyBasicForm> {
  final TextEditingController _companyName = TextEditingController();
  final TextEditingController _tradeLicense = TextEditingController();
  final TextEditingController _abbr = TextEditingController();
  final TextEditingController _dateOfIncorporationStr = TextEditingController();
  DateTime? dateOfIncorporation;
  final TextEditingController _website = TextEditingController();
  late final CompanyFormCubit _controller;
  final PassByReference<String?> _activities = PassByReference(null);
  int? _parentCompanyId;
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
          children: [
            SizedBox(height: 20),
            CustomTextFormField(
              label: 'Company Name',
              placeholder: 'Enter Company Name',
              controller: _companyName,
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
              controller: _tradeLicense,
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
              controller: _abbr,
            ),
            SizedBox(height: 10),
            CustomDateField(
              label: 'Date of Incorporation',
              req: false,
              onDateSubmit: (date) {
                dateOfIncorporation = date;
              },
              initialDate: parseDateTime(_controller.state.company?.data?.incoporationDate),
              textEditingController: _dateOfIncorporationStr,
            ),
            SizedBox(height: 10),
            CustomTextFormField(
              label: 'Website',
              placeholder: 'Enter Website',
              req: false,
              controller: _website,
            ),
            SizedBox(height: 10),
            Builder(
              builder: (context) {
                final companies = context.read<CompaniesIndexCubit>().state.data ?? [];
                return DropDownWidget(
                  label: 'Parent Company',
                  initialValue:
                      _controller.state.company?.data?.parentCompany == null
                          ? null
                          : companies
                              .where((c) => c.id == _controller.state.company?.data?.parentCompany)
                              .toList()
                              .firstOrNull
                              ?.companyName,
                  options: companies.map((c) => c.companyName ?? '').toList(),
                  onSelect: (String? selectedCompanyName) {
                    _parentCompanyId =
                        companies
                            .where((c) => c.companyName == selectedCompanyName)
                            .toList()
                            .firstOrNull
                            ?.id;
                  },
                  req: false,
                  // placeholder: 'Enter Parent Company',
                );
              },
            ),
            SizedBox(height: 10),
            Builder(
              builder: (context) {
                List<String> activitiesList = [];
                if (_activities.data?.trim().isNotEmpty == true) {
                  activitiesList = _activities.data?.trim().split(',') ?? [];
                }
                return CustomMultipleTextFormField(
                  label: 'Business Activities',
                  placeholder: 'Enter Business Activities',
                  req: false,
                  onSelected: (value) {},
                  initialValues: activitiesList,
                  valueByReference: _activities,
                );
              },
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

  void _initializeFields() {
    _companyName.text = _controller.state.company?.data?.companyName ?? '';
    _tradeLicense.text = _controller.state.company?.data?.tradeLicenseNumber ?? '';
    _abbr.text = _controller.state.company?.data?.abbr ?? '';
    _website.text = _controller.state.company?.data?.websiteUrl ?? '';
    dateOfIncorporation = parseDateTime(_controller.state.company?.data?.incoporationDate);
    _activities.data = _controller.state.company?.data?.businessActivities;
  }

  void _disposeControllers() {
    _companyName.dispose();
    _tradeLicense.dispose();
    _abbr.dispose();
    _dateOfIncorporationStr.dispose();
  }

  Future _sendRequest() async {
    if (_formKey.currentState!.validate()) {
      CompanyModel companyInState = _controller.state.company?.data ?? CompanyModel();
      CompanyModel companyUpdated = companyInState.copyWith(
        companyName: _companyName.text,
        tradeLicenseNumber: _tradeLicense.text,
        abbr: _abbr.text,
        incoporationDate: dateOfIncorporation?.toIso8601String(),
        websiteUrl: _website.text,
        businessActivities: _activities.data,
        parentCompany: _parentCompanyId,
      );
      // pr(companyUpdated, 'companyUpdated');
      // return;
      _controller.state.company!.data = companyUpdated;
      await _controller.basic();
    }
  }
}
