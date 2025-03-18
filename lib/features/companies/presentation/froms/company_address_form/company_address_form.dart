import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/extensions/context-extensions.dart';
import 'package:hr/core/heleprs/validator.dart';
import 'package:hr/core/models/pass_by_reference.dart';
import 'package:hr/core/widgets/inputs.dart';
import 'package:hr/features/companies/cubits/company_address_cubit.dart';
import 'package:hr/features/companies/presentation/froms/company_address_form/widgets/state_city_selector_widget.dart';
import 'package:hr/features/companies/presentation/widgets/basic_info_filled_widget.dart';
import 'package:hr/features/companies/presentation/widgets/form_vertical_gap.dart';
import 'package:hr/features/companies/presentation/widgets/section_title.dart';
import 'package:hr/utils/styles/styles.dart';

class CompanyAddressProvider extends StatelessWidget {
  const CompanyAddressProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompanyAddressCubit(),
      child: const CompanyAddressForm(),
    );
  }
}

class CompanyAddressForm extends StatefulWidget {
  const CompanyAddressForm({super.key});

  @override
  State<CompanyAddressForm> createState() => _CompanyAddressFormState();
}

class _CompanyAddressFormState extends State<CompanyAddressForm> {
  final TextEditingController registeredBuildingOfficeName = TextEditingController();
  final TextEditingController registeredStreetAddress = TextEditingController();
  final TextEditingController registeredPoBox = TextEditingController();
  final TextEditingController operationalBuildingOfficeName = TextEditingController();
  final TextEditingController operationalStreetAddress = TextEditingController();
  final TextEditingController operationalPoBox = TextEditingController();
  final PassByReference<int?> selectedRegisteredCity = PassByReference(null);
  final PassByReference<int?> selectedRegisteredState = PassByReference(null);
  final PassByReference<int?> selectedOperationalCity = PassByReference(null);
  final PassByReference<int?> selectedOperationalState = PassByReference(null);
  late final CompanyAddressCubit _controller;
  final _formKey = GlobalKey<FormState>();
  bool isTheSame = false;
  @override
  void initState() {
    _controller = context.read<CompanyAddressCubit>();
    // _controller.contactShow(context);
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
      currentTab: 2,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              SectionTitle(title: 'Registered Address'),
              FormVerticalGap(),
              CustomTextFormField(
                label: 'Building / Office Name',
                placeholder: 'Enter Building / Office Name',
                controller: registeredBuildingOfficeName,
                validator:
                    (input) => valdiator(
                      input: input,
                      label: 'Building / Office Name',
                      isRequired: true,
                      minChars: 5,
                      maxChars: 50,
                    ),
              ),
              FormVerticalGap(),
              CustomTextFormField(
                label: 'Street Address:',
                placeholder: 'Enter Street Address:',
                controller: registeredStreetAddress,
                validator:
                    (input) => valdiator(
                      input: input,
                      label: 'Street Address:',
                      isRequired: true,
                      minChars: 5,
                      maxChars: 50,
                    ),
              ),
              FormVerticalGap(),
              StateCitySelectorWidget(selectedRegisteredState, selectedRegisteredCity),
              FormVerticalGap(),
              CustomTextFormField(
                label: 'Po Box',
                placeholder: 'Enter Po Box',
                controller: registeredPoBox,
                validator:
                    (input) => valdiator(
                      input: input,
                      label: 'Po Box',
                      isRequired: true,
                      minChars: 5,
                      maxChars: 50,
                    ),
              ),
              FormVerticalGap(),
              Transform.translate(
                offset: Offset(-10, 0),
                child: Row(
                  children: [
                    Checkbox(
                      value: isTheSame,
                      onChanged: (value) {
                        setState(() {
                          isTheSame = !isTheSame;
                        });
                      },
                      activeColor: context.primaryColor,
                    ),
                    Flexible(
                      child: txt('Operational Address Same as Registered Address', e: St.bold16),
                    ),
                  ],
                ),
              ),
              FormVerticalGap(),
              if (!isTheSame)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionTitle(title: 'Operational Address'),
                    FormVerticalGap(),
                    CustomTextFormField(
                      label: 'Building / Office Name',
                      placeholder: 'Enter Building / Office Name',
                      controller: operationalBuildingOfficeName,
                      validator:
                          (input) => valdiator(
                            input: input,
                            label: 'Building / Office Name',
                            isRequired: true,
                            minChars: 5,
                            maxChars: 50,
                          ),
                    ),
                    FormVerticalGap(),
                    CustomTextFormField(
                      label: 'Street Address:',
                      placeholder: 'Enter Street Address:',
                      controller: operationalStreetAddress,
                      validator:
                          (input) => valdiator(
                            input: input,
                            label: 'Street Address:',
                            isRequired: true,
                            minChars: 5,
                            maxChars: 50,
                          ),
                    ),
                    FormVerticalGap(),
                    StateCitySelectorWidget(selectedOperationalState, selectedOperationalCity),
                    FormVerticalGap(),
                    CustomTextFormField(
                      label: 'Po Box',
                      placeholder: 'Enter Po Box',
                      controller: operationalPoBox,
                      validator:
                          (input) => valdiator(
                            input: input,
                            label: 'Po Box',
                            isRequired: true,
                            minChars: 5,
                            maxChars: 50,
                          ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _initializeFields() {
    registeredBuildingOfficeName.text = _controller.state.data?.registeredBuildingOfficeName ?? '';
    registeredStreetAddress.text = _controller.state.data?.registeredStreetAddress ?? '';
    registeredPoBox.text = _controller.state.data?.registeredPoBox ?? '';
    operationalBuildingOfficeName.text =
        _controller.state.data?.operationalBuildingOfficeName ?? '';
    operationalStreetAddress.text = _controller.state.data?.operationalStreetAddress ?? '';
    operationalPoBox.text = _controller.state.data?.operationalPoBox ?? '';
  }

  void _disposeControllers() {
    registeredBuildingOfficeName.dispose();
    registeredStreetAddress.dispose();
    registeredPoBox.dispose();
    operationalBuildingOfficeName.dispose();
    operationalStreetAddress.dispose();
    operationalPoBox.dispose();
  }

  Future _sendRequest() async {
    if (_formKey.currentState!.validate()) {
      // _controller.contactUpsert(
      //   context,
      //   CompanyContactModel(
      //     contactName: _contactName.text,
      //     companyEmail: _companyEmail.text,
      //     primaryMobileNumber: _primaryMobileNumber.text,
      //     secondaryMobileNumber: _secondaryMobileNumber.text,
      //     landlineNumber: _landlineNumber.text,
      //     faxNumber: _faxNumber.text,
      //     hrMobileNumber: _hrMobileNumber.text,
      //     hrLandlineNumber: _hrLandlineNumber.text,
      //     hrEmail: _hrEmail.text,
      //   ),
      // );
    }
  }
}
