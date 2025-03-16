import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/heleprs/format_date.dart';
import 'package:hr/core/heleprs/validator.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/widgets/inputs.dart';
import 'package:hr/core/widgets/save_button.dart';
import 'package:hr/features/companies/cubits/company_legal_cubit.dart';
import 'package:hr/features/companies/helpers/get_company.dart';
import 'package:hr/features/companies/models/company_legal_model.dart';
import 'package:hr/features/companies/presentation/widgets/basic_info_filled_widget.dart';
import 'package:hr/features/companies/presentation/widgets/form_vertical_gap.dart';

class CompanyLegalProvider extends StatelessWidget {
  const CompanyLegalProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => CompanyLegalCubit(), child: const CompanyLegalForm());
  }
}

class CompanyLegalForm extends StatefulWidget {
  const CompanyLegalForm({super.key});

  @override
  State<CompanyLegalForm> createState() => _CompanyLegalFormState();
}

class _CompanyLegalFormState extends State<CompanyLegalForm> {
  final TextEditingController _tradeLicenseExpiryDate = TextEditingController();
  final TextEditingController _vatRegistrationNumber = TextEditingController();
  final TextEditingController _chamberOfCommerceMembershipNumber = TextEditingController();
  late final CompanyLegalCubit _controller;
  DateTime? _expiryDatetime;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _controller = context.read<CompanyLegalCubit>();
    _controller.legalShow(context);
    super.initState();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompanyBasicInfoFilledWidget(
      currentTab: 6,
      child: BlocBuilder<CompanyLegalCubit, ApiCrudResponseModel<CompanyLegalModel>>(
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
                  CustomDateField(
                    label: 'Trade License Expiry Date',
                    req: true,
                    onDateSubmit: (date) {
                      _expiryDatetime = date;
                    },
                    initialDate: parseDateTime(_controller.state.data?.tradeLicenseExpiryDate),
                    textEditingController: _tradeLicenseExpiryDate,
                    validator:
                        (input) => valdiator(
                          input: input,
                          label: 'Trade License Expiry Date',
                          isRequired: true,
                        ),
                  ),
                  FormVerticalGap(),
                  CustomTextFormField(
                    label: 'VAT Registration Number',
                    placeholder: 'Enter VAT Registration Number',
                    controller: _vatRegistrationNumber,
                    validator:
                        (input) => valdiator(
                          input: input,
                          label: 'VAT Registration Number',
                          isRequired: true,
                          minChars: 3,
                          maxChars: 50,
                        ),
                  ),
                  FormVerticalGap(),
                  CustomTextFormField(
                    label: 'Chamber of Commerce Membership Number',
                    placeholder: 'Enter Chamber of Commerce Membership Number',
                    controller: _chamberOfCommerceMembershipNumber,
                    showNumberOnly: true,
                    validator:
                        (input) => valdiator(
                          input: input,
                          label: 'Chamber of Commerce Membership Number',
                          isRequired: true,
                          minChars: 3,
                          maxChars: 50,
                        ),
                  ),

                  SizedBox(height: 30),
                  BlocBuilder<CompanyLegalCubit, ApiCrudResponseModel<CompanyLegalModel>>(
                    builder: (context, state) {
                      if (state.upsertResponse == ResponseEnum.loading) {
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
                  SizedBox(height: 300),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _initializeFields() {
    _tradeLicenseExpiryDate.text = _controller.state.data?.tradeLicenseExpiryDate ?? '';
    _vatRegistrationNumber.text = _controller.state.data?.vatRegistrationNumber ?? '';
    _chamberOfCommerceMembershipNumber.text =
        _controller.state.data?.chamberOfCommerceMembershipNumber ?? '';
  }

  void _disposeControllers() {
    _vatRegistrationNumber.dispose();
    _chamberOfCommerceMembershipNumber.dispose();
    _tradeLicenseExpiryDate.dispose();
  }

  Future _sendRequest() async {
    if (_formKey.currentState!.validate()) {
      _controller.legalUpsert(
        context,
        CompanyLegalModel(
          tradeLicenseExpiryDate: _expiryDatetime?.toIso8601String(),
          vatRegistrationNumber: _vatRegistrationNumber.text,
          chamberOfCommerceMembershipNumber: _chamberOfCommerceMembershipNumber.text,
          companyBasicId: getCompany(context)?.id,
        ),
      );
    }
  }
}
