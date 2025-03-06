import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hr/core/extensions/context-extensions.dart';
import 'package:hr/core/widgets/main_scaffold.dart';
import 'package:hr/features/companies/models/company_model.dart';

class ComapanyEditView extends StatefulWidget {
  const ComapanyEditView({super.key, required this.company});
  final CompanyModel company;
  @override
  State<ComapanyEditView> createState() => _ComapanyEditViewState();
}

class _ComapanyEditViewState extends State<ComapanyEditView> {
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
        appBarTitle: widget.company.name,
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
                children:
                    tabs.map((tab) {
                      // Each tab content is centered with a text
                      return Center(
                        child: Text(
                              "Content for $tab",
                              style: TextStyle(fontSize: 20),
                            )
                            // Animate the content with a fade in and slight slide
                            .animate()
                            .fadeIn(duration: Duration(milliseconds: 500))
                            .slide(
                              begin: Offset(0, 0.1),
                              duration: Duration(milliseconds: 500),
                            ),
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
