// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/service_locator/service_locator.dart';
import 'package:hr/core/widgets/handle_response_widget.dart';
import 'package:hr/core/widgets/show_are_you_sure_dialog.dart';
import 'package:hr/features/companies/controllers/company_form_controller.dart';
import 'package:hr/features/companies/cubits/company_departments_index_cubit.dart';
import 'package:hr/features/companies/models/company_main_department_model/company_main_department_model.dart';
import 'package:hr/features/companies/presentation/froms/company_department_form/widgets/edit_main_department_model.dart';
import 'package:hr/utils/styles/styles.dart';

class Department {
  final int id;
  final String subDepartment;
  final String mainDepartment;

  Department({
    required this.id,
    required this.subDepartment,
    required this.mainDepartment,
  });
}

class MainDepartmentTableWidget extends StatefulWidget {
  const MainDepartmentTableWidget({super.key});

  @override
  _MainDepartmentTableWidgetState createState() =>
      _MainDepartmentTableWidgetState();
}

class _MainDepartmentTableWidgetState extends State<MainDepartmentTableWidget> {
  @override
  void initState() {
    super.initState();
  }

  final borderSide = BorderSide(color: Colors.grey);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
          CompanyDepartmentsIndexCubit,
          ApiResponseModel<List<CompanyMainDepartmentModel>>
        >(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: HandleResponseWidget(
                response: state.response ?? ResponseEnum.initial,
                showNoData:
                    state.data?.isEmpty == true &&
                    state.response == ResponseEnum.success,
                child: ListView.builder(
                  // physics: NeverScrollableScrollPhysics(),
                  itemCount: (state.data?.length ?? 0) + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide()),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: txt(
                                'Main\nDepartment',
                                e: St.bold16,
                                textAlign: TextAlign.center,
                              ),
                            ),

                            Expanded(
                              flex: 1,
                              child: txt(
                                'Action',
                                e: St.bold16,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    index = index - 1;
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        border: Border(bottom: borderSide),
                      ),

                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  left: borderSide,
                                  right: borderSide,
                                ),
                              ),
                              child: txt(
                                state.data?[index].name ?? '',
                                e: St.reg16,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(right: borderSide),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                        onTap: () {
                                          if (state.data?[index] != null) {
                                            _showEditMainDepartmentModel(
                                              (state.data?[index])!,
                                            );
                                          }
                                        },
                                        child: Icon(Icons.edit, size: 25),
                                      )
                                      .animate()
                                      .fadeIn(
                                        duration: const Duration(
                                          milliseconds: 300,
                                        ),
                                      )
                                      .slideX(
                                        begin: -0.1,
                                        duration: const Duration(
                                          milliseconds: 300,
                                        ),
                                      ),
                                  SizedBox(width: 10),
                                  InkWell(
                                        onTap: () {
                                          if (state.data?[index] != null) {
                                            _deleteMainDepartment(
                                              (state.data?[index])!,
                                            );
                                          }
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          size: 25,
                                          color: Colors.redAccent,
                                        ),
                                      )
                                      .animate()
                                      .fadeIn(
                                        duration: const Duration(
                                          milliseconds: 300,
                                        ),
                                      )
                                      .slideX(
                                        begin: 0.1,
                                        duration: const Duration(
                                          milliseconds: 300,
                                        ),
                                      ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        )
        .animate()
        .fadeIn(duration: const Duration(milliseconds: 600))
        .slideY(begin: 0.2, duration: const Duration(milliseconds: 600));
  }

  _showEditMainDepartmentModel(CompanyMainDepartmentModel departmentModel) {
    showDialog(
      context: context,
      builder: (context) {
        return EditMainDepartmentModel(departmentModel);
      },
    );
  }

  _deleteMainDepartment(CompanyMainDepartmentModel departmentModel) async {
    bool? confirm = await showAreYouSureDialog();
    if (confirm != true) return;
    final controller = serviceLocator<CompanyFormController>();
    final res = await controller.deleteMainDepartment(departmentModel);
    if (res.response == ResponseEnum.success &&
        departmentModel.companyId != null) {
      context.read<CompanyDepartmentsIndexCubit>().index(
        departmentModel.companyId!,
      );
    }
  }
}
