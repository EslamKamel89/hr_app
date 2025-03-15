import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/features/companies/cubits/company_form/company_form_cubit.dart';
import 'package:hr/features/companies/helpers/get_company.dart';

class CompanyBasicInfoFilledWidget extends StatelessWidget {
  const CompanyBasicInfoFilledWidget({
    super.key,
    required this.child,
    required this.currentTab,
  });
  final Widget child;
  final int currentTab;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyFormCubit, CompanyFormState>(
      buildWhen: (previous, current) {
        return (previous.currentTab != currentTab &&
            current.currentTab == currentTab);
      },
      builder: (context, state) {
        if (getCompany(context) == null) {
          return Center(
            child: Text(
              "Please Fill Your Basic Data First",
              style: TextStyle(fontSize: 20),
            ),
          );
        }
        return child;
      },
    );
  }
}
