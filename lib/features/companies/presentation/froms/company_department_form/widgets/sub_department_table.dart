import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/widgets/handle_response_widget.dart';
import 'package:hr/core/widgets/show_are_you_sure_dialog.dart';
import 'package:hr/features/companies/cubits/company_departments_index_cubit.dart';
import 'package:hr/features/companies/entiites/sub_department_entity.dart';
import 'package:hr/features/companies/models/company_main_department_model/company_main_department_model.dart';
import 'package:hr/features/companies/models/company_main_department_model/sub_department.dart';
import 'package:hr/features/companies/presentation/froms/company_department_form/widgets/edit_sub_department_model.dart';
import 'package:hr/utils/styles/styles.dart';

class SubDepartmentTableWidget extends StatefulWidget {
  const SubDepartmentTableWidget({super.key});

  @override
  _SubDepartmentTableWidgetState createState() => _SubDepartmentTableWidgetState();
}

class _SubDepartmentTableWidgetState extends State<SubDepartmentTableWidget> {
  late final CompanyDepartmentsIndexCubit _departmentIndexController;

  @override
  void initState() {
    _departmentIndexController = context.read<CompanyDepartmentsIndexCubit>();
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
                showNoData: state.data?.isEmpty == true && state.response == ResponseEnum.success,
                child: Builder(
                  builder: (context) {
                    List<SubDepartmentEntity> data = _transformData(
                      state.data ?? <CompanyMainDepartmentModel>[],
                    );
                    return ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      itemCount: data.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            padding: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(border: Border(bottom: BorderSide())),
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
                                  flex: 2,
                                  child: txt(
                                    'Sub\nDepartment',
                                    e: St.bold16,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: txt('Action', e: St.bold16, textAlign: TextAlign.center),
                                ),
                              ],
                            ),
                          );
                        }
                        index = index - 1;
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(border: Border(bottom: borderSide)),

                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(left: borderSide, right: borderSide),
                                  ),
                                  child: txt(
                                    data[index].mainDepartment ?? '',
                                    e: St.reg16,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: BoxDecoration(border: Border(right: borderSide)),
                                  child: txt(
                                    data[index].subDepartment ?? '',
                                    e: St.reg16,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(border: Border(right: borderSide)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                            onTap: () {
                                              _showEditSubDepartmentModel();
                                            },
                                            child: Icon(Icons.edit, size: 25),
                                          )
                                          .animate()
                                          .fadeIn(duration: const Duration(milliseconds: 300))
                                          .slideX(
                                            begin: -0.1,
                                            duration: const Duration(milliseconds: 300),
                                          ),
                                      SizedBox(width: 10),
                                      InkWell(
                                            onTap: () {
                                              _deleteSubDepartment();
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              size: 25,
                                              color: Colors.redAccent,
                                            ),
                                          )
                                          .animate()
                                          .fadeIn(duration: const Duration(milliseconds: 300))
                                          .slideX(
                                            begin: 0.1,
                                            duration: const Duration(milliseconds: 300),
                                          ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
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

  _showEditSubDepartmentModel() {
    showDialog(
      context: context,
      builder: (context) {
        return EditSubDepartmentModel();
      },
    );
  }

  _deleteSubDepartment() {
    showAreYouSureDialog();
  }

  List<SubDepartmentEntity> _transformData(List<CompanyMainDepartmentModel> departments) {
    List<SubDepartmentEntity> result = [];
    for (var department in departments) {
      for (var subDepartment in department.subDepartments ?? <CompanySubDepartmentModel>[]) {
        result.add(
          SubDepartmentEntity(
            companyId: department.companyId,
            departmentId: department.id,
            subDepartmentId: subDepartment.subDeptId,
            mainDepartment: department.name,
            subDepartment: subDepartment.subDepartmentName,
          ),
        );
      }
    }
    return result;
  }
}
