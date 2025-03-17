import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hr/core/models/pass_by_reference.dart';
import 'package:hr/core/widgets/inputs.dart';
import 'package:hr/core/widgets/save_button.dart';
import 'package:hr/features/companies/presentation/widgets/basic_info_filled_widget.dart';
import 'package:hr/features/companies/presentation/widgets/form_vertical_gap.dart';

class CompanyAttachmentProvider extends StatelessWidget {
  const CompanyAttachmentProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return const CompanyAttachmentsForm();
  }
}

class CompanyAttachmentsForm extends StatefulWidget {
  const CompanyAttachmentsForm({super.key});

  @override
  State<CompanyAttachmentsForm> createState() => _CompanyAttachmentsFormState();
}

class _CompanyAttachmentsFormState extends State<CompanyAttachmentsForm> {
  // late final CompanyContactCubit _controller;
  final _formKey = GlobalKey<FormState>();
  final PassByReference<File?> _tradeLicense = PassByReference(null);
  final PassByReference<File?> _ownerEmirateIdFrontCopy = PassByReference(null);
  final PassByReference<File?> _ownerEmirateIdBackCopy = PassByReference(null);
  final PassByReference<File?> _ownerPassportCopy = PassByReference(null);
  final PassByReference<File?> _vatRegisterationCertificateCopy = PassByReference(null);
  final PassByReference<File?> _chamberOfCommerceCertificateCopy = PassByReference(null);
  @override
  void initState() {
    // _controller = context.read<CompanyContactCubit>();
    // _controller.contactShow(context);
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            UploadFileWidget(
              label: 'Trade License',
              file: _tradeLicense,
              path: "https://hr.gaztec.org/uploads/companies/attachments/8/1742197966.png",
            ),
            FormVerticalGap(),
            UploadFileWidget(label: "Owner Emirate ID Front Copy", file: _ownerEmirateIdFrontCopy),
            UploadFileWidget(label: "Owner Emirate ID Back Copy", file: _ownerEmirateIdBackCopy),
            UploadFileWidget(label: "Owner Passport Copy", file: _ownerPassportCopy),
            UploadFileWidget(
              label: "VAT Registration Certificate Copy",
              file: _vatRegisterationCertificateCopy,
            ),
            UploadFileWidget(
              label: "Chamber of Commerce Certificate Copy",
              file: _chamberOfCommerceCertificateCopy,
            ),
            SizedBox(height: 30),
            SaveButton(onTap: () {}),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  void _initializeFields() {}

  void _disposeControllers() {}

  Future _sendRequest() async {
    if (_formKey.currentState!.validate()) {}
  }
}
