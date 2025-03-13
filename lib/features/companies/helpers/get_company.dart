import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/heleprs/print_helper.dart';
import 'package:hr/features/companies/cubits/company_form/company_form_cubit.dart';
import 'package:hr/features/companies/models/company_model.dart';

CompanyModel? getCompany(BuildContext context) {
  // try {
  pr('getCompany');
  // BuildContext? context = navigatorKey.currentContext;
  // pr(context, 'context');
  // if (context == null) return null;
  return pr(context.read<CompanyFormCubit>().state.company?.data, 'company');
}
