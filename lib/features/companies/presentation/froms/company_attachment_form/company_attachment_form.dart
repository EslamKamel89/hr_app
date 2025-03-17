import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/api_service/end_points.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/models/pass_by_reference.dart';
import 'package:hr/core/widgets/inputs.dart';
import 'package:hr/core/widgets/save_button.dart';
import 'package:hr/features/companies/controllers/params/company_attachments_params.dart';
import 'package:hr/features/companies/cubits/company_attachments_cubit.dart';
import 'package:hr/features/companies/models/company_attachments_model.dart';
import 'package:hr/features/companies/presentation/widgets/basic_info_filled_widget.dart';
import 'package:hr/features/companies/presentation/widgets/form_vertical_gap.dart';

class CompanyAttachmentProvider extends StatelessWidget {
  const CompanyAttachmentProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompanyAttachmentsCubit(),
      child: const CompanyAttachmentsForm(),
    );
  }
}

class CompanyAttachmentsForm extends StatefulWidget {
  const CompanyAttachmentsForm({super.key});

  @override
  State<CompanyAttachmentsForm> createState() => _CompanyAttachmentsFormState();
}

class _CompanyAttachmentsFormState extends State<CompanyAttachmentsForm> {
  late final CompanyAttachmentsCubit _controller;
  final PassByReference<File?> _tradeLicense = PassByReference(null);
  final PassByReference<File?> _ownerEmirateIdFrontCopy = PassByReference(null);
  final PassByReference<File?> _ownerEmirateIdBackCopy = PassByReference(null);
  final PassByReference<File?> _ownerPassportCopy = PassByReference(null);
  final PassByReference<File?> _vatRegisterationCertificateCopy = PassByReference(null);
  final PassByReference<File?> _chamberOfCommerceCertificateCopy = PassByReference(null);
  @override
  void initState() {
    _controller = context.read<CompanyAttachmentsCubit>();
    _controller.attachmentsShow(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompanyBasicInfoFilledWidget(
      currentTab: 2,
      child: BlocBuilder<CompanyAttachmentsCubit, ApiCrudResponseModel<CompanyAttachmentsModel>>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                UploadFileWidget(
                  label: 'Trade License',
                  file: _tradeLicense,
                  path: "${EndPoint.uploadUrl}${state.data?.getPath()}${state.data?.tradeLicense}",
                ),
                FormVerticalGap(),
                UploadFileWidget(
                  label: "Owner Emirate ID Front Copy",
                  file: _ownerEmirateIdFrontCopy,
                  path:
                      "${EndPoint.uploadUrl}${state.data?.getPath()}${state.data?.ownerEmirateIdFrontCopy}",
                ),
                UploadFileWidget(
                  label: "Owner Emirate ID Back Copy",
                  file: _ownerEmirateIdBackCopy,
                  path:
                      "${EndPoint.uploadUrl}${state.data?.getPath()}${state.data?.ownerEmirateIdBackCopy}",
                ),
                UploadFileWidget(
                  label: "Owner Passport Copy",
                  file: _ownerPassportCopy,
                  path:
                      "${EndPoint.uploadUrl}${state.data?.getPath()}${state.data?.ownerPassportCopy}",
                ),
                UploadFileWidget(
                  label: "VAT Registration Certificate Copy",
                  file: _vatRegisterationCertificateCopy,
                  path:
                      "${EndPoint.uploadUrl}${state.data?.getPath()}${state.data?.vatRegisterationCertificateCopy}",
                ),
                UploadFileWidget(
                  label: "Chamber of Commerce Certificate Copy",
                  file: _chamberOfCommerceCertificateCopy,
                  path:
                      "${EndPoint.uploadUrl}${state.data?.getPath()}${state.data?.chamberOfCommerceCertificateCopy}",
                ),
                SizedBox(height: 30),
                BlocBuilder<CompanyAttachmentsCubit, ApiCrudResponseModel<CompanyAttachmentsModel>>(
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

  Future _sendRequest() async {
    _controller.attachmentUpsert(
      context,
      CompanyAttachmentsParams(
        tradeLicense: _tradeLicense.data,
        ownerEmirateIdFrontCopy: _ownerEmirateIdFrontCopy.data,
        ownerEmirateIdBackCopy: _ownerEmirateIdBackCopy.data,
        ownerPassportCopy: _ownerPassportCopy.data,
        vatRegisterationCertificateCopy: _vatRegisterationCertificateCopy.data,
        chamberOfCommerceCertificateCopy: _chamberOfCommerceCertificateCopy.data,
      ),
    );
  }
}
