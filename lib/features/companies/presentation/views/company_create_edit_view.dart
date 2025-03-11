import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hr/core/extensions/context-extensions.dart';
import 'package:hr/core/widgets/inputs.dart';
import 'package:hr/core/widgets/main_scaffold.dart';
import 'package:hr/features/companies/models/company_model.dart';
import 'package:hr/utils/styles/styles.dart';

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

class CompanyBasicForm extends StatefulWidget {
  const CompanyBasicForm({super.key});

  @override
  State<CompanyBasicForm> createState() => _CompanyBasicFormState();
}

class _CompanyBasicFormState extends State<CompanyBasicForm> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
          CustomTextFormField(
            label: 'Company Name',
            placeholder: 'Enter Company Name',
          ),
          SizedBox(height: 10),
          CustomTextFormField(
            label: 'Trade License No',
            placeholder: 'Enter Trade License No',
          ),
          SizedBox(height: 10),
          CustomTextFormField(
            label: 'Abbr',
            placeholder: 'Enter Abbr',
            req: false,
          ),
          SizedBox(height: 10),
          CustomDateField(
            label: 'Date of Incorporation',
            req: false,
            onDateSubmit: (data) {},
            initialDate: DateTime.now(),
            textEditingController: TextEditingController(),
            // placeholder: 'Enter Date of Incorporation',
          ),
          SizedBox(height: 10),
          CustomTextFormField(
            label: 'Website',
            placeholder: 'Enter Website',
            req: false,
          ),
          SizedBox(height: 10),
          DropDownWidget(
            label: 'Parent Company',
            options: [],
            onSelect: () {},
            req: false,
            // placeholder: 'Enter Parent Company',
          ),
          SizedBox(height: 10),
          CustomMultipleTextFormField(
            label: 'Business Activities',
            placeholder: 'Enter Business Activities',
            req: false,
            onSelected: (value) {},
            controller: TextEditingController(),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {},
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: txt('Save', e: St.bold18),
            ),
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
