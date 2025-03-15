import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/heleprs/validator.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/widgets/inputs.dart';
import 'package:hr/core/widgets/save_button.dart';
import 'package:hr/features/companies/cubits/upsert_main_department_cubit.dart';
import 'package:hr/features/companies/models/company_main_department_model/company_main_department_model.dart';
import 'package:hr/features/companies/presentation/widgets/form_vertical_gap.dart';
import 'package:hr/utils/styles/styles.dart';

class EditMainDepartmentModel extends StatefulWidget {
  const EditMainDepartmentModel(this.departmentModel, {super.key});
  final CompanyMainDepartmentModel departmentModel;
  @override
  State<EditMainDepartmentModel> createState() => _EditMainDepartmentModelState();
}

class _EditMainDepartmentModelState extends State<EditMainDepartmentModel> {
  final TextEditingController _name = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _name.text = widget.departmentModel.name ?? '';
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
        create: (context) => UpsertMainDepartmentCubit(),
        child:
            BlocConsumer<UpsertMainDepartmentCubit, ApiResponseModel<CompanyMainDepartmentModel>>(
              listener: (context, state) {
                if (state.response == ResponseEnum.success) {
                  Navigator.of(context).pop();
                }
              },
              builder: (context, state) {
                final controller = context.read<UpsertMainDepartmentCubit>();
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
                            txt('Edit Main Department', e: St.bold20),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(Icons.close),
                            ),
                          ],
                        ),
                        FormVerticalGap(),
                        CustomTextFormField(
                          placeholder: 'Enter Main Department',
                          controller: _name,
                          validator:
                              (input) => valdiator(
                                input: input,
                                label: 'Main Department',
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
                                    widget.departmentModel.copyWith(name: _name.text),
                                  );
                                }
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
