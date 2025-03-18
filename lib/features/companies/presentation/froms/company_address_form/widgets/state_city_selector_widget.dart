import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/models/pass_by_reference.dart';
import 'package:hr/core/widgets/inputs/custom_dropdown_widget.dart';
import 'package:hr/features/companies/cubits/state_%20city_cubit/state_city_cubit.dart';
import 'package:hr/features/companies/presentation/widgets/form_vertical_gap.dart';

class StateCityProvider extends StatelessWidget {
  const StateCityProvider({super.key, required this.selectedState, required this.selectedCity});
  final PassByReference<int?> selectedCity;
  final PassByReference<int?> selectedState;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StateCityCubit(),
      child: StateCitySelectorWidget(selectedState: selectedState, selectedCity: selectedCity),
    );
  }
}

class StateCitySelectorWidget extends StatefulWidget {
  const StateCitySelectorWidget({
    super.key,
    required this.selectedState,
    required this.selectedCity,
  });
  final PassByReference<int?> selectedCity;
  final PassByReference<int?> selectedState;
  @override
  State<StateCitySelectorWidget> createState() => _StateCitySelectorWidgetState();
}

class _StateCitySelectorWidgetState extends State<StateCitySelectorWidget> {
  late final StateCityCubit _controller;
  final PassByReference<String?> cityValue = PassByReference(null);
  @override
  void initState() {
    _controller = context.read<StateCityCubit>();
    _controller.fetchStates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StateCityCubit, StateCityState>(
      listener: (context, state) {
        widget.selectedState.data = state.selectedState?.id;
        widget.selectedCity.data = state.selectedCity?.id;
      },
      builder: (context, state) {
        return Column(
          children: [
            DropDownWidget2(
              options: (state.cities.data ?? []).map((e) => e.name ?? '').toList(),
              label: 'City',
              onSelect: (value) {
                if (value != null) _controller.selectCity(value);
              },
              hint: state.selectedState == null ? 'please select a State first ' : 'Select city',
              req: true,
              // initialValue: state.selectedCity?.name,
              value: cityValue,
            ),
            FormVerticalGap(),
            DropDownWidget(
              options: (state.states.data ?? []).map((e) => e.name ?? '').toList(),
              label: 'Emirate / State',
              hint: 'Select State',
              onSelect: (value) {
                cityValue.data = null;
                if (value != null) _controller.selectState(value);
              },
              initialValue: state.selectedState?.name,
              req: true,
            ),
          ],
        );
      },
    );
  }
}
