import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/extensions/context-extensions.dart';
import 'package:hr/features/companies/cubits/company_departments_index_cubit.dart';
import 'package:hr/features/companies/helpers/get_company.dart';
import 'package:hr/features/companies/presentation/froms/company_department_form/widgets/add_main_department.dart';
import 'package:hr/features/companies/presentation/froms/company_department_form/widgets/add_sub_department.dart';
import 'package:hr/features/companies/presentation/froms/company_department_form/widgets/main_department_table.dart';
import 'package:hr/features/companies/presentation/froms/company_department_form/widgets/sub_department_table.dart';
import 'package:hr/features/companies/presentation/widgets/basic_info_filled_widget.dart';
import 'package:hr/features/companies/presentation/widgets/form_vertical_gap.dart';
import 'package:hr/utils/styles/styles.dart';

class CompanyDepartmentForm extends StatefulWidget {
  const CompanyDepartmentForm({super.key});

  @override
  State<CompanyDepartmentForm> createState() => _CompanyDepartmentFormState();
}

class _CompanyDepartmentFormState extends State<CompanyDepartmentForm>
    with SingleTickerProviderStateMixin {
  late final CompanyDepartmentsIndexCubit _departmentIndexController;
  final _formKey = GlobalKey<FormState>();
  late final TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _departmentIndexController = context.read<CompanyDepartmentsIndexCubit>();
    int? id = getCompany(context)?.id;
    if (id != null) _departmentIndexController.index(id);
    super.initState();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompanyBasicInfoFilledWidget(
      currentTab: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AddMainDepartment(),
          FormVerticalGap(),
          AddSubDepartment(),
          FormVerticalGap(),
          Builder(
            builder: (context) {
              return TabBar(
                controller: _tabController,
                indicatorColor: context.secondaryHeaderColor,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                tabs: [
                  Tab(child: txt('Main Departments')),
                  Tab(child: txt('Sub Departments')),
                ],
              );
            },
          ),
          Expanded(
            // height: 700,
            child: TabBarView(
              controller: _tabController,
              children: [
                MainDepartmentTableWidget(),
                SubDepartmentTableWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _initializeFields() {}

  void _disposeControllers() {
    _tabController.dispose();
  }

  Future _sendRequest() async {
    if (_formKey.currentState!.validate()) {}
  }
}
