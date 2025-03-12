import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hr/core/extensions/context-extensions.dart';
import 'package:hr/core/widgets/main_scaffold.dart';
import 'package:hr/features/companies/models/company_model.dart';
import 'package:hr/features/companies/presentation/froms/company_basic_form.dart';

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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: MainScaffold(
        appBarTitle: widget.company?.companyName ?? 'Create company',
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
                  ...tabs.where((tab) => !['Basic'].contains(tab)).map((tab) {
                    return Center(
                      child: Text(
                            "Content for $tab",
                            style: TextStyle(fontSize: 20),
                          )
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
  }
}
