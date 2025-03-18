import 'package:flutter/material.dart';
import 'package:hr/core/models/pass_by_reference.dart';
import 'package:hr/core/widgets/inputs.dart';
import 'package:hr/features/companies/presentation/widgets/form_vertical_gap.dart';

class StateCitySelectorWidget extends StatefulWidget {
  const StateCitySelectorWidget(this.selectedState, this.selectedCity, {super.key});
  final PassByReference<int?> selectedCity;
  final PassByReference<int?> selectedState;
  @override
  State<StateCitySelectorWidget> createState() => _StateCitySelectorWidgetState();
}

class _StateCitySelectorWidgetState extends State<StateCitySelectorWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropDownWidget(options: [], label: 'City', onSelect: (value) {}, req: true),
        FormVerticalGap(),
        DropDownWidget(options: [], label: 'Emirate / State', onSelect: (value) {}, req: true),
      ],
    );
  }
}
