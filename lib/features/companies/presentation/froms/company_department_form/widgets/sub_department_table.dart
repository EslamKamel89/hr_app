import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hr/core/widgets/show_are_you_sure_dialog.dart';
import 'package:hr/features/companies/presentation/froms/company_department_form/widgets/edit_sub_department_model.dart';
import 'package:hr/features/companies/presentation/froms/company_department_form/widgets/main_department_table.dart';
import 'package:hr/utils/styles/styles.dart';

class SubDepartmentTableWidget extends StatefulWidget {
  const SubDepartmentTableWidget({super.key});

  @override
  _SubDepartmentTableWidgetState createState() => _SubDepartmentTableWidgetState();
}

class _SubDepartmentTableWidgetState extends State<SubDepartmentTableWidget> {
  @override
  void initState() {
    super.initState();
  }

  List<Department> _generateData() {
    return List.generate(
      50,
      (index) => Department(
        id: index + 1,
        subDepartment: "This is Sub Department ${index + 1}",
        mainDepartment: "This is Main Department ${((index) / 5).floor() + 1}",
      ),
    );
  }

  final borderSide = BorderSide(color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: _generateData().length + 1,
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
                      child: txt('Main\nDepartment', e: St.bold16, textAlign: TextAlign.center),
                    ),
                    Expanded(
                      flex: 2,
                      child: txt('Sub\nDepartment', e: St.bold16, textAlign: TextAlign.center),
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
                        _generateData()[index].mainDepartment,
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
                        _generateData()[index].subDepartment,
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
                              .slideX(begin: -0.1, duration: const Duration(milliseconds: 300)),
                          SizedBox(width: 10),
                          InkWell(
                                onTap: () {
                                  _deleteSubDepartment();
                                },
                                child: Icon(Icons.delete, size: 25, color: Colors.redAccent),
                              )
                              .animate()
                              .fadeIn(duration: const Duration(milliseconds: 300))
                              .slideX(begin: 0.1, duration: const Duration(milliseconds: 300)),
                        ],
                      ),
                    ),
                  ),
                ],
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
}
