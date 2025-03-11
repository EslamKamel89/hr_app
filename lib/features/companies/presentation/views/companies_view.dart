// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/router/app_routes_names.dart';
import 'package:hr/core/widgets/default_drawer.dart';
import 'package:hr/core/widgets/handle_response_widget.dart';
import 'package:hr/core/widgets/main_scaffold.dart';
import 'package:hr/features/companies/cubits/companies_index_cubit.dart';
import 'package:hr/features/companies/models/company_model.dart';
import 'package:hr/features/companies/presentation/widgets/company_card.dart';

class CompaniesView extends StatefulWidget {
  const CompaniesView({super.key});

  @override
  State<CompaniesView> createState() => _CompaniesViewState();
}

class _CompaniesViewState extends State<CompaniesView> {
  final TextEditingController _searchController = TextEditingController();

  final String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // final filteredEmployees =
    //     employees.where((e) {
    //       return e.name.toLowerCase().contains(_searchQuery.toLowerCase());
    //     }).toList();
    // return MainScaffold(
    //   appBarTitle: 'Error',
    //   drawer: DefaultDrawer(),
    //   child: SizedBox(),
    // );
    // ignore: dead_code
    return BlocProvider(
      create: (context) => CompaniesIndexCubit()..index(),
      child: BlocBuilder<
        CompaniesIndexCubit,
        ApiResponseModel<List<CompanyModel>>
      >(
        builder: (context, state) {
          final controller = context.read<CompaniesIndexCubit>();
          // state.response = ResponseEnum.failed;
          return MainScaffold(
            appBarTitle: 'Companies',
            drawer: DefaultDrawer(),

            // child: SizedBox(),
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
                          // setState(() {
                          //   _searchQuery = value;
                          // });
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
                Expanded(
                  child: HandleResponseWidget(
                    response: state.response ?? ResponseEnum.initial,
                    showNoData: state.data?.isEmpty,
                    tryAgain: () {
                      controller.index();
                    },
                    child: ListView.builder(
                      itemCount: state.data?.length,
                      itemBuilder: (context, index) {
                        final employee = state.data?[index];
                        if (employee == null) {
                          return SizedBox();
                        }
                        return CompanyCard(company: employee, number: index + 1)
                            .animate()
                            .fadeIn(duration: Duration(milliseconds: 500))
                            .slide(begin: Offset(0, 0.1));
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
