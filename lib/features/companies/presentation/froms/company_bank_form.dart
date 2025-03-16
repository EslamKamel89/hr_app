import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/heleprs/validator.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/widgets/inputs.dart';
import 'package:hr/core/widgets/save_button.dart';
import 'package:hr/features/companies/cubits/company_bank_cubit.dart';
import 'package:hr/features/companies/helpers/get_company.dart';
import 'package:hr/features/companies/models/company_bank_model.dart';
import 'package:hr/features/companies/presentation/widgets/basic_info_filled_widget.dart';
import 'package:hr/features/companies/presentation/widgets/form_vertical_gap.dart';

class CompanyBankProvider extends StatelessWidget {
  const CompanyBankProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => CompanyBankCubit(), child: const CompanyBankForm());
  }
}

class CompanyBankForm extends StatefulWidget {
  const CompanyBankForm({super.key});

  @override
  State<CompanyBankForm> createState() => _CompanyBankFormState();
}

class _CompanyBankFormState extends State<CompanyBankForm> {
  final TextEditingController _tradeLicenseExpiryDate = TextEditingController();
  final TextEditingController _bankName = TextEditingController();
  final TextEditingController _accountNumber = TextEditingController();
  final TextEditingController _ibanNumber = TextEditingController();
  final TextEditingController _swiftCode = TextEditingController();

  late final CompanyBankCubit _controller;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _controller = context.read<CompanyBankCubit>();
    _controller.bankShow(context);
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
      currentTab: 5,
      child: BlocBuilder<CompanyBankCubit, ApiCrudResponseModel<CompanyBankModel>>(
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
                  CustomTextFormField(
                    label: 'Bank Nick Name',
                    placeholder: 'Enter Bank Nick Name',
                    controller: _tradeLicenseExpiryDate,
                    validator:
                        (input) => valdiator(
                          input: input,
                          label: 'Bank Nick Name:',
                          isRequired: true,
                          minChars: 3,
                          maxChars: 50,
                        ),
                  ),
                  FormVerticalGap(),
                  CustomTextFormField(
                    label: 'Bank Name',
                    placeholder: 'Enter Bank Name',
                    controller: _bankName,
                    validator:
                        (input) => valdiator(
                          input: input,
                          label: 'Bank Name',
                          isRequired: true,
                          minChars: 3,
                          maxChars: 50,
                        ),
                  ),
                  FormVerticalGap(),
                  CustomTextFormField(
                    label: 'Account Number',
                    placeholder: 'Enter Account Number',
                    controller: _accountNumber,
                    showNumberOnly: true,
                    validator:
                        (input) => valdiator(
                          input: input,
                          label: 'Account Number',
                          isRequired: true,
                          minChars: 3,
                          maxChars: 50,
                        ),
                  ),
                  FormVerticalGap(),
                  CustomTextFormField(
                    label: 'IBAN Number',
                    placeholder: 'Enter IBAN Number',
                    controller: _ibanNumber,
                    showNumberOnly: true,
                    validator:
                        (input) => valdiator(
                          input: input,
                          label: 'IBAN Number',
                          isRequired: true,
                          minChars: 3,
                          maxChars: 50,
                        ),
                  ),
                  FormVerticalGap(),
                  CustomTextFormField(
                    label: 'Swift Code',
                    placeholder: 'Enter Swift Code',
                    controller: _swiftCode,
                    showNumberOnly: true,
                    validator:
                        (input) => valdiator(
                          input: input,
                          label: 'Swift Code',
                          isRequired: true,
                          minChars: 3,
                          maxChars: 50,
                        ),
                  ),
                  SizedBox(height: 30),
                  BlocBuilder<CompanyBankCubit, ApiCrudResponseModel<CompanyBankModel>>(
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
    _tradeLicenseExpiryDate.text = _controller.state.data?.bankNickName ?? '';
    _bankName.text = _controller.state.data?.bankName ?? '';
    _accountNumber.text = _controller.state.data?.bankAccountNumber ?? '';
    _ibanNumber.text = _controller.state.data?.bankAccountIbanNumber ?? '';
    _swiftCode.text = _controller.state.data?.swiftCode ?? '';
  }

  void _disposeControllers() {
    _tradeLicenseExpiryDate.dispose();
    _bankName.dispose();
    _accountNumber.dispose();
    _ibanNumber.dispose();
    _swiftCode.dispose();
  }

  Future _sendRequest() async {
    if (_formKey.currentState!.validate()) {
      _controller.bankUpsert(
        context,
        CompanyBankModel(
          companyBasicId: getCompany(context)?.id,
          bankNickName: _tradeLicenseExpiryDate.text,
          bankName: _bankName.text,
          bankAccountNumber: _accountNumber.text,
          bankAccountIbanNumber: _ibanNumber.text,
          swiftCode: _swiftCode.text,
        ),
      );
    }
  }
}
