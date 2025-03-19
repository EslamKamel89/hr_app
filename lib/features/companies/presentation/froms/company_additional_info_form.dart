import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/heleprs/print_helper.dart';
import 'package:hr/core/heleprs/snackbar.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/models/pass_by_reference.dart';
import 'package:hr/core/widgets/inputs/upload_file_widget.dart';
import 'package:hr/core/widgets/save_button.dart';
import 'package:hr/features/companies/controllers/params/company_additional_info_params.dart';
import 'package:hr/features/companies/cubits/company_additonal_info_cubit.dart';
import 'package:hr/features/companies/helpers/get_company.dart';
import 'package:hr/features/companies/models/company_additional_info_model.dart';
import 'package:hr/features/companies/presentation/widgets/basic_info_filled_widget.dart';

class CompanyAdditionalProvider extends StatelessWidget {
  const CompanyAdditionalProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompanyAdditionalInfoCubit(),
      child: const CompanyAdditionalForm(),
    );
  }
}

class CompanyAdditionalForm extends StatefulWidget {
  const CompanyAdditionalForm({super.key});

  @override
  State<CompanyAdditionalForm> createState() => _CompanyAdditionalFormState();
}

class _CompanyAdditionalFormState extends State<CompanyAdditionalForm> {
  final PassByReference<File?> _logo = PassByReference(null);
  late final CompanyAdditionalInfoCubit _controller;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _controller = context.read<CompanyAdditionalInfoCubit>();
    _controller.additionalInfoShow(context);
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
      currentTab: 2,
      child:
          BlocBuilder<CompanyAdditionalInfoCubit, ApiCrudResponseModel<CompanyAdditionalInfoModel>>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    UploadFileWidget(
                      label: 'Company Logo',
                      file: _logo,
                      path: state.data?.getPath(),
                    ),
                    SizedBox(height: 30),
                    BlocBuilder<
                      CompanyAdditionalInfoCubit,
                      ApiCrudResponseModel<CompanyAdditionalInfoModel>
                    >(
                      builder: (context, state) {
                        if (state.upsertResponse == ResponseEnum.loading) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return SaveButton(
                          onTap: () {
                            _sendRequest();
                          },
                        );
                      },
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              );
            },
          ),
    );
  }

  void _initializeFields() {}

  void _disposeControllers() {}

  Future _sendRequest() async {
    if (_logo.data == null) {
      showSnackbar('Error', 'Please Pick A Logo', true);
      return;
    }
    final company = getCompany(context);
    if (company == null || company.id == null) {
      pr('Error" company basic data cant be null', 'CompanyAdditionalForm widget');
      return;
    }
    _controller.additionalInfoUpsert(
      context,
      CompanyAdditionalInfoParams(companyLogo: _logo.data, companyBasicId: company.id),
    );
  }
}
