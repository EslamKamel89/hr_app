import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/heleprs/validator.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/widgets/inputs.dart';
import 'package:hr/core/widgets/save_button.dart';
import 'package:hr/features/companies/cubits/company_departments_index_cubit.dart';
import 'package:hr/features/companies/cubits/upsert_sub_department_cubit.dart';
import 'package:hr/features/companies/models/company_main_department_model/company_main_department_model.dart';
import 'package:hr/features/companies/models/company_main_department_model/compoany_sub_department_model.dart';
import 'package:hr/features/companies/presentation/widgets/form_vertical_gap.dart';
import 'package:hr/utils/styles/styles.dart';

class EditSubDepartmentModel extends StatefulWidget {
  const EditSubDepartmentModel(this.subDepartmentModel, {super.key});
  final CompanySubDepartmentModel subDepartmentModel;

  @override
  State<EditSubDepartmentModel> createState() => _EditSubDepartmentModelState();
}

class _EditSubDepartmentModelState extends State<EditSubDepartmentModel> {
  final TextEditingController _name = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int? parentDepartmentId;

  @override
  void initState() {
    _name.text = widget.subDepartmentModel.subDepartmentName ?? '';
    parentDepartmentId = widget.subDepartmentModel.parentDepartmentId;
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: BlocProvider(
        create: (context) => UpsertSubDepartmentCubit(),
        child: BlocConsumer<
          UpsertSubDepartmentCubit,
          ApiResponseModel<CompanySubDepartmentModel>
        >(
          listener: (context, state) {
            if (state.response == ResponseEnum.success) {
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            final controller = context.read<UpsertSubDepartmentCubit>();
            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        txt('Edit Sub Department', e: St.bold20),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.close),
                        ),
                      ],
                    ),
                    FormVerticalGap(),
                    BlocBuilder<
                      CompanyDepartmentsIndexCubit,
                      ApiResponseModel<List<CompanyMainDepartmentModel>>
                    >(
                      builder: (context, state) {
                        List<String> options =
                            state.data?.map((e) => e.name ?? '').toList() ?? [];
                        return DropDownWidget(
                          label: 'Pick Main Department',
                          initialValue:
                              state.data
                                  ?.where(
                                    (parent) =>
                                        parent.id ==
                                        widget
                                            .subDepartmentModel
                                            .parentDepartmentId,
                                  )
                                  .toList()
                                  .firstOrNull
                                  ?.name ??
                              options[0],
                          options:
                              state.data?.map((e) => e.name ?? '').toList() ??
                              [],
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
                            if (_formKey.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              await controller.upsert(
                                widget.subDepartmentModel.copyWith(
                                  subDepartmentName: _name.text,
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
      ),
    );
  }
}
