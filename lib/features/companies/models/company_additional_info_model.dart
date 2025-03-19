import 'package:hr/core/api_service/end_points.dart';

class CompanyAdditionalInfoModel {
  int? id;
  String? companyLogo;
  String? path;
  int? companyBasicId;

  CompanyAdditionalInfoModel({this.id, this.companyLogo, this.path, this.companyBasicId});

  @override
  String toString() =>
      'CompanyAdditionalInfoModel(id: $id, logo: $companyLogo , path: $path , companyBasicId: $companyBasicId)';

  factory CompanyAdditionalInfoModel.fromJson(Map<String, dynamic> json) =>
      CompanyAdditionalInfoModel(
        id: json['id'] as int?,
        companyLogo: json['company_logo'] as String?,
        path: json['path'] as String?,
        companyBasicId:
            json['company_basic_id'] == null
                ? null
                : int.parse(json['company_basic_id'].toString()),
      );

  Map<String, dynamic> toJson() => {'id': id, 'company_logo': companyLogo};

  CompanyAdditionalInfoModel copyWith({
    int? id,
    String? companyLogo,
    String? path,
    int? companyBasicId,
  }) {
    return CompanyAdditionalInfoModel(
      id: id ?? this.id,
      companyLogo: companyLogo ?? this.companyLogo,
      path: path ?? this.path,
      companyBasicId: companyBasicId ?? this.companyBasicId,
    );
  }

  String? getPath() {
    return "${EndPoint.uploadUrl}${path?.split('public/').last}$companyLogo";
  }
}
