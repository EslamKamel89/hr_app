import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/globals.dart';
import 'package:hr/core/heleprs/print_helper.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/service_locator/service_locator.dart';
import 'package:hr/features/companies/controllers/company_form_controller.dart';
import 'package:hr/features/companies/cubits/company_departments_index_cubit.dart';
import 'package:hr/features/companies/models/company_main_department_model/compoany_sub_department_model.dart';

class UpsertSubDepartmentCubit extends Cubit<ApiResponseModel<CompanySubDepartmentModel>> {
  CompanyFormController controller = serviceLocator();
  UpsertSubDepartmentCubit() : super(ApiResponseModel.initial());
  Future upsert(CompanySubDepartmentModel model) async {
    final t = prt('create - UpsertSubDepartmentCubit');

    emit(state.copyWith(response: ResponseEnum.loading));
    pr('Loading....', t);
    final department = await controller.upsertSubDepartment(model);
    pr(department, t);
    emit(department);
    BuildContext? context = navigatorKey.currentContext;
    if (context == null || model.companyId == null) return;
    context.read<CompanyDepartmentsIndexCubit>().index(model.companyId!);
  }
}
