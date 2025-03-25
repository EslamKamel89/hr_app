import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/widgets/inputs/custom_dropdown_widget.dart';
import 'package:hr/features/companies/cubits/company_address_cubit.dart';
import 'package:hr/features/companies/cubits/state_%20city_cubit/state_city_cubit.dart';
import 'package:hr/features/companies/models/company_address_model.dart';
import 'package:hr/features/companies/presentation/widgets/form_vertical_gap.dart';

class StateCityProvider extends StatelessWidget {
  const StateCityProvider({super.key, this.isOperational = false});
  final bool isOperational;

  @override
  Widget build(BuildContext context) {
    return StateCitySelectorWidget(isOperational: isOperational);
  }
}

class StateCitySelectorWidget extends StatefulWidget {
  const StateCitySelectorWidget({super.key, required this.isOperational});
  final bool isOperational;
  @override
  State<StateCitySelectorWidget> createState() => _StateCitySelectorWidgetState();
}

class _StateCitySelectorWidgetState extends State<StateCitySelectorWidget> {
  late final StateCityCubit _controller;
  late final CompanyAddressCubit _addressController;
  @override
  void initState() {
    _controller = context.read<StateCityCubit>();
    _addressController = context.read<CompanyAddressCubit>();
    _initialize();

    super.initState();
  }

  Future _initialize() async {
    await _controller.fetchStates();
    // if (widget.selectedStateId.data == null) return;
    // await _controller.selectState(stateId: widget.selectedStateId.data);
    // if (widget.selectedCityId.data != null) {
    // await _controller.selectCity(cityId: widget.selectedCityId.data);
    // }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CompanyAddressCubit, ApiCrudResponseModel<CompanyAddressModel>>(
      listener: (context, state) async {
        if (state.showResponse != ResponseEnum.success) return;

        if (state.data?.registeredEmirateState != null) {
          await _controller.selectState(stateId: state.data?.registeredEmirateState!);
          if (state.data?.registeredCity != null) {
            await _controller.selectCity(cityId: state.data?.registeredCity!);
          }
        }
        if (state.data?.operationalEmirateState != null) {
          await _controller.selectState(
            stateId: state.data?.operationalEmirateState!,
            isOperational: true,
          );
          if (state.data?.operationalCity != null) {
            await _controller.selectCity(cityId: state.data?.operationalCity!, isOperational: true);
          }
        }
      },
      child: BlocConsumer<StateCityCubit, StateCityState>(
        listener: (context, state) {
          // widget.selectedStateId.data = state.selectedState?.id;
          // widget.selectedCityId.data = state.selectedCity?.id;
        },
        builder: (context, state) {
          return Column(
            children: [
              !widget.isOperational
                  ? DropDownWidget(
                    options: (state.cities.data ?? []).map((e) => e.name ?? '').toList(),
                    label: 'City',
                    onSelect: (value) {
                      if (value != null) _controller.selectCity(cityName: value);
                    },
                    hint:
                        state.selectedState == null
                            ? 'please select a State first '
                            : 'Select city',
                    req: true,
                    initialValue: state.selectedCity?.name,
                  )
                  : DropDownWidget(
                    options: (state.citiesOperational.data ?? []).map((e) => e.name ?? '').toList(),
                    label: 'City',
                    onSelect: (value) {
                      if (value != null) {
                        _controller.selectCity(cityName: value, isOperational: true);
                      }
                    },
                    hint:
                        state.selectedOperationalState == null
                            ? 'please select a State first '
                            : 'Select city',
                    req: true,
                    initialValue: state.selectedOperationalCity?.name,
                  ),
              FormVerticalGap(),
              !widget.isOperational
                  ? DropDownWidget(
                    options: (state.states.data ?? []).map((e) => e.name ?? '').toList(),
                    label: 'Emirate / State',
                    hint: 'Select State',
                    onSelect: (value) {
                      // _controller.selectedCityName.data = null;
                      if (value != null) _controller.selectState(stateName: value);
                    },
                    initialValue: state.selectedState?.name,
                    req: true,
                  )
                  : DropDownWidget(
                    options: (state.states.data ?? []).map((e) => e.name ?? '').toList(),
                    label: 'Emirate / State',
                    hint: 'Select State',
                    onSelect: (value) {
                      // _controller.selectedCityName.data = null;
                      if (value != null) {
                        _controller.selectState(stateName: value, isOperational: true);
                      }
                    },
                    initialValue: state.selectedOperationalState?.name,
                    req: true,
                  ),
            ],
          );
        },
      ),
    );
  }
}
