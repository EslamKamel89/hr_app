import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/heleprs/print_helper.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/service_locator/service_locator.dart';
import 'package:hr/features/companies/controllers/company_form_controller.dart';
import 'package:hr/features/companies/controllers/params/company_attachments_params.dart';
import 'package:hr/features/companies/helpers/get_company.dart';
import 'package:hr/features/companies/models/company_attachments_model.dart';

class CompanyAttachmentsCubit extends Cubit<ApiCrudResponseModel<CompanyAttachmentsModel>> {
  CompanyFormController controller = serviceLocator();
  CompanyAttachmentsCubit() : super(ApiCrudResponseModel.initial());
  Future attachmentsShow(BuildContext context) async {
    final t = prt('attachmentsShow - CompanyAttachmentsCubit');
    final company = getCompany(context);
    if (company == null || company.id == null) {
      pr('Error" company basic data cant be null', t);
      return;
    }
    emit(
      state.copyWith(
        showResponse: ResponseEnum.loading,
        upsertResponse: ResponseEnum.initial,
        data: null,
        errorMessage: null,
      ),
    );
    pr('Loading....', t);
    final attachmentsRes = await controller.attachmentShow(company.id!);
    pr(attachmentsRes, t);
    if (!isClosed) {
      emit(attachmentsRes);
    }
  }

  Future attachmentUpsert(BuildContext context, CompanyAttachmentsParams params) async {
    final t = prt('attachmentUpsert - CompanyAttachmentsCubit');
    final company = getCompany(context);
    if (company == null || company.id == null) {
      pr('Error" company basic data cant be null', t);
      return;
    }
    emit(
      state.copyWith(
        upsertResponse: ResponseEnum.loading,
        showResponse: ResponseEnum.initial,
        data: null,
        errorMessage: null,
      ),
    );
    pr('Loading....', t);
    final attachmentRes = await controller.attachmentUpsert(company.id!, params);
    pr(attachmentRes, t);
    emit(attachmentRes);
  }
}
