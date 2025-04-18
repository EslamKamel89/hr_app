import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/extensions/context-extensions.dart';
import 'package:hr/core/heleprs/validator.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/widgets/inputs/custom_text_form_field.dart';
import 'package:hr/core/widgets/save_button.dart';
import 'package:hr/features/companies/cubits/company_address_cubit.dart';
import 'package:hr/features/companies/cubits/state_%20city_cubit/state_city_cubit.dart';
import 'package:hr/features/companies/models/company_address_model.dart';
import 'package:hr/features/companies/presentation/froms/company_address_form/widgets/state_city_selector_widget.dart';
import 'package:hr/features/companies/presentation/widgets/basic_info_filled_widget.dart';
import 'package:hr/features/companies/presentation/widgets/form_vertical_gap.dart';
import 'package:hr/features/companies/presentation/widgets/section_title.dart';
import 'package:hr/utils/styles/styles.dart';

class CompanyAddressProvider extends StatelessWidget {
  const CompanyAddressProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CompanyAddressCubit()),
        BlocProvider(create: (context) => StateCityCubit()),
      ],
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

  late final CompanyAddressCubit _controller;
  late final StateCityCubit _stateCityController;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _controller = context.read<CompanyAddressCubit>();
    _stateCityController = context.read<StateCityCubit>();
    _controller.addressShow(context);
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
      child: BlocBuilder<CompanyAddressCubit, ApiCrudResponseModel<CompanyAddressModel>>(
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
                  StateCityProvider(),
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
                          value: _controller.isTheSame,
                          onChanged: (value) {
                            setState(() {
                              _controller.isTheSame = !_controller.isTheSame;
                            });
                          },
                          activeColor: context.primaryColor,
                        ),
                        Flexible(
                          child: txt(
                            'Operational Address Same as Registered Address',
                            e: St.bold16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  FormVerticalGap(),
                  // if (!_controller.isTheSame)
                  Builder(
                    builder: (context) {
                      final col = Column(
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
                          StateCityProvider(isOperational: true),
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
                      );

                      return !_controller.isTheSame ? col : SizedBox();
                    },
                  ),
                  SizedBox(height: 30),
                  BlocBuilder<CompanyAddressCubit, ApiCrudResponseModel<CompanyAddressModel>>(
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
      final address = CompanyAddressModel(
        registeredBuildingOfficeName: registeredBuildingOfficeName.text,
        registeredStreetAddress: registeredStreetAddress.text,
        registeredCity: _stateCityController.state.selectedCity?.id,
        registeredEmirateState: _stateCityController.state.selectedState?.id,
        registeredPoBox: registeredPoBox.text,
        operationalBuildingOfficeName: operationalBuildingOfficeName.text,
        operationalStreetAddress: operationalStreetAddress.text,
        operationalCity: _stateCityController.state.selectedOperationalCity?.id,
        operationalEmirateState: _stateCityController.state.selectedOperationalState?.id,
        operationalPoBox: operationalPoBox.text,
        addressSame: _controller.isTheSame ? 'yes' : 'no',
      );
      // pr(address, 'address params');
      // return;
      _controller.addressUpsert(context, address);
    }
  }
}
