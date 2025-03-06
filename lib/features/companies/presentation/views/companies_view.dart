import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hr/core/router/app_routes_names.dart';
import 'package:hr/core/widgets/default_drawer.dart';
import 'package:hr/core/widgets/main_scaffold.dart';
import 'package:hr/features/companies/models/company_model.dart';
import 'package:hr/features/companies/presentation/widgets/company_card.dart';

class CompaniesView extends StatefulWidget {
  const CompaniesView({super.key});

  @override
  State<CompaniesView> createState() => _CompaniesViewState();
}

class _CompaniesViewState extends State<CompaniesView> {
  final TextEditingController _searchController = TextEditingController();
  final List<CompanyModel> employees = [
    CompanyModel(
      id: 1,
      name: 'Alice Johnson',
      createdAt: DateTime(2020, 4, 16),
      employeesCount: 5,
    ),
    CompanyModel(
      id: 2,
      name: 'Bob Smith',
      createdAt: DateTime(2021, 2, 10),
      employeesCount: 5,
    ),
    CompanyModel(
      id: 3,
      name: 'Charlie Brown',
      createdAt: DateTime(2022, 7, 22),
      employeesCount: 5,
    ),
  ];

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredEmployees =
        employees.where((e) {
          return e.name.toLowerCase().contains(_searchQuery.toLowerCase());
        }).toList();
    return MainScaffold(
      appBarTitle: 'Companies',
      drawer: DefaultDrawer(),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search employees...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
              SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutesNames.companyCreateEditView,
                    arguments: null,
                  );
                },
                icon: Icon(Icons.add),
                label: Text('Add'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          // List of employee cards
          Expanded(
            child: ListView.builder(
              itemCount: filteredEmployees.length,
              itemBuilder: (context, index) {
                final employee = filteredEmployees[index];
                return CompanyCard(company: employee, number: index + 1)
                    .animate()
                    .fadeIn(duration: Duration(milliseconds: 500))
                    .slide(begin: Offset(0, 0.1));
              },
            ),
          ),
        ],
      ),
    );
  }
}
