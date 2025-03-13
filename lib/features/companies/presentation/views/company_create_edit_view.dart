import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/extensions/context-extensions.dart';
import 'package:hr/core/globals.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/widgets/main_scaffold.dart';
import 'package:hr/features/companies/cubits/companies_index_cubit.dart';
import 'package:hr/features/companies/cubits/company_form/company_form_cubit.dart';
import 'package:hr/features/companies/models/company_model.dart';
import 'package:hr/features/companies/presentation/froms/company_basic_form.dart';
import 'package:hr/features/companies/presentation/froms/company_contact_form.dart';

class ComapanyCreateEditView extends StatefulWidget {
  const ComapanyCreateEditView({super.key, required this.company});
  final CompanyModel? company;
  @override
  State<ComapanyCreateEditView> createState() => _ComapanyCreateEditViewState();
}

class _ComapanyCreateEditViewState extends State<ComapanyCreateEditView> {
  final List<String> tabs = [
    "Basic",
    "Contact",
    "Address",
    "Departments",
    "Bank Details",
    "Legal Details",
    "Attachments",
    "Additional Info",
  ];
  // void didPopNext(Route<dynamic> nextRoute) {
  //   super.did
  // }
  @override
  void dispose() {
    navigatorKey.currentContext?.read<CompaniesIndexCubit>().index();
    // context.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompanyFormCubit(),
      child: Builder(
        builder: (context) {
          final controller = context.read<CompanyFormCubit>();
          if (widget.company != null) {
            controller.state.company = ApiResponseModel(
              data: widget.company,
              response: ResponseEnum.success,
            );
          }
          return DefaultTabController(
            length: tabs.length,
            child: MainScaffold(
              appBarTitleWidget: BlocBuilder<CompanyFormCubit, CompanyFormState>(
                builder: (context, state) {
                  return Text(controller.state.company?.data?.companyName ?? 'Create company');
                },
              ),
              child: Column(
                children: [
                  TabBar(
                    isScrollable: true,
                    indicatorColor: context.secondaryHeaderColor,
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    tabs: tabs.map((tab) => Tab(text: tab)).toList(),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        CompanyBasicForm(),
                        CompanyContactForm(),
                        ...tabs.where((tab) => !['Basic', 'Contact'].contains(tab)).map((tab) {
                          return Center(
                            child: Text("Content for $tab", style: TextStyle(fontSize: 20))
                                .animate()
                                .fadeIn(duration: Duration(milliseconds: 500))
                                .slide(
                                  begin: Offset(0, 0.1),
                                  duration: Duration(milliseconds: 500),
                                ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
