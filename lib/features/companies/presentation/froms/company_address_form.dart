import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/features/companies/cubits/company_form/company_form_cubit.dart';
import 'package:hr/features/companies/helpers/get_company.dart';

class CompanyAddressProvider extends StatelessWidget {
  const CompanyAddressProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return const CompanyAddressForm();
  }
}

class CompanyAddressForm extends StatefulWidget {
  const CompanyAddressForm({super.key});

  @override
  State<CompanyAddressForm> createState() => _CompanyAddressFormState();
}

class _CompanyAddressFormState extends State<CompanyAddressForm> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyFormCubit, CompanyFormState>(
      buildWhen: (previous, current) {
        return (previous.currentTab != 2 && current.currentTab == 2);
      },
      builder: (context, state) {
        if (getCompany(context) == null) {
          return Center(
            child: Text("Please Fill Your Basic Data First", style: TextStyle(fontSize: 20)),
          );
        }
        return const Placeholder();
      },
    );
  }
}
