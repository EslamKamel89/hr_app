import 'compoany_sub_department_model.dart';

class CompanyMainDepartmentModel {
  int? id;
  String? name;
  int? companyId;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  List<CompanySubDepartmentModel>? subDepartments;

  CompanyMainDepartmentModel({
    this.id,
    this.name,
    this.companyId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.subDepartments,
  });

  @override
  String toString() {
    return 'CompanyMainDepartmentModel(id: $id, name: $name, companyId: $companyId, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, subDepartments: $subDepartments)';
  }

  factory CompanyMainDepartmentModel.fromJson(Map<String, dynamic> json) {
    return CompanyMainDepartmentModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      companyId: json['company_id'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as dynamic,
      subDepartments:
          (json['sub_departments'] as List<dynamic>?)
              ?.map(
                (e) => CompanySubDepartmentModel.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    // 'id': id,
    'name': name,
    'company_id': companyId,
    // 'created_at': createdAt,
    // 'updated_at': updatedAt,
    // 'deleted_at': deletedAt,
    // 'sub_departments': subDepartments?.map((e) => e.toJson()).toList(),
  };

  CompanyMainDepartmentModel copyWith({
    int? id,
    String? name,
    int? companyId,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
    List<CompanySubDepartmentModel>? subDepartments,
  }) {
    return CompanyMainDepartmentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      companyId: companyId ?? this.companyId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      subDepartments: subDepartments ?? this.subDepartments,
    );
  }
}
