import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/heleprs/validator.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/widgets/collapsible_card.dart';
import 'package:hr/core/widgets/inputs/custom_dropdown_widget.dart';
import 'package:hr/core/widgets/inputs/custom_text_form_field.dart';
import 'package:hr/core/widgets/save_button.dart';
import 'package:hr/features/companies/cubits/company_departments_index_cubit.dart';
import 'package:hr/features/companies/cubits/upsert_sub_department_cubit.dart';
import 'package:hr/features/companies/helpers/get_company.dart';
import 'package:hr/features/companies/models/company_main_department_model/company_main_department_model.dart';
import 'package:hr/features/companies/models/company_main_department_model/compoany_sub_department_model.dart';
import 'package:hr/features/companies/presentation/widgets/form_vertical_gap.dart';
import 'package:hr/utils/styles/styles.dart';

class AddSubDepartment extends StatefulWidget {
  const AddSubDepartment({super.key});

  @override
  State<AddSubDepartment> createState() => _AddSubDepartmentState();
}

class _AddSubDepartmentState extends State<AddSubDepartment> {
  final TextEditingController _name = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int? parentDepartmentId;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpsertSubDepartmentCubit(),
      child: BlocBuilder<UpsertSubDepartmentCubit, ApiResponseModel<CompanySubDepartmentModel>>(
        builder: (context, state) {
          final controller = context.read<UpsertSubDepartmentCubit>();
          return Form(
            key: _formKey,
            child: CollapsibleCard(
              header: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [txt('Add Sub Department'), Icon(Icons.add)],
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormVerticalGap(),
                  BlocBuilder<
                    CompanyDepartmentsIndexCubit,
                    ApiResponseModel<List<CompanyMainDepartmentModel>>
                  >(
                    builder: (context, state) {
                      List<String> options = state.data?.map((e) => e.name ?? '').toList() ?? [];

                      return DropDownWidget(
                        label: 'Pick Main Department',
                        // initialValue: options[0],
                        options: state.data?.map((e) => e.name ?? '').toList() ?? [],
                        onSelect: (value) {
                          state.data?.forEach((mainDepartment) {
                            if (mainDepartment.name == value) {
                              parentDepartmentId = mainDepartment.id;
                            }
                          });
                        },
                      );
                    },
                  ),
                  FormVerticalGap(),
                  CustomTextFormField(
                    placeholder: 'Enter Sub Department',
                    controller: _name,
                    validator:
                        (input) => valdiator(
                          input: input,
                          label: 'Sub Department',
                          isRequired: true,
                          minChars: 2,
                          maxChars: 50,
                        ),
                  ),
                  FormVerticalGap(),
                  state.response == ResponseEnum.loading
                      ? Center(child: CircularProgressIndicator())
                      : SaveButton(
                        onTap: () async {
                          // pr(
                          //   CompanySubDepartmentModel(
                          //     subDepartmentName: _name.text,
                          //     companyId: getCompany(context)?.id,
                          //     parentDepartmentId: parentDepartmentId,
                          //   ),
                          //   'CompanySubDepartmentModel',
                          // );
                          // return;
                          if (_formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            await controller.upsert(
                              CompanySubDepartmentModel(
                                subDepartmentName: _name.text,
                                companyId: getCompany(context)?.id,
                                parentDepartmentId: parentDepartmentId,
                              ),
                            );
                          }
                          _name.text = '';
                        },
                        title: 'Create',
                      ),
                  FormVerticalGap(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
