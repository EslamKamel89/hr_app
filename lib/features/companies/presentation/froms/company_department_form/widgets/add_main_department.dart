import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/heleprs/validator.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/widgets/collapsible_card.dart';
import 'package:hr/core/widgets/inputs.dart';
import 'package:hr/core/widgets/save_button.dart';
import 'package:hr/features/companies/cubits/upsert_main_department_cubit.dart';
import 'package:hr/features/companies/helpers/get_company.dart';
import 'package:hr/features/companies/models/company_main_department_model/company_main_department_model.dart';
import 'package:hr/features/companies/presentation/widgets/form_vertical_gap.dart';
import 'package:hr/utils/styles/styles.dart';

class AddMainDepartment extends StatefulWidget {
  const AddMainDepartment({super.key});

  @override
  State<AddMainDepartment> createState() => _AddMainDepartmentState();
}

class _AddMainDepartmentState extends State<AddMainDepartment> {
  final TextEditingController _name = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpsertMainDepartmentCubit(),
      child: BlocBuilder<
        UpsertMainDepartmentCubit,
        ApiResponseModel<CompanyMainDepartmentModel>
      >(
        builder: (context, state) {
          final controller = context.read<UpsertMainDepartmentCubit>();
          return Form(
            key: _formKey,
            child: CollapsibleCard(
              header: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [txt('Add Main Department'), Icon(Icons.add)],
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                              CompanyMainDepartmentModel(
                                name: _name.text,
                                companyId: getCompany(context)?.id,
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
