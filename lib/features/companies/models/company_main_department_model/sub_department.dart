class CompanySubDepartment {
  int? subDeptId;
  int? companyId;
  String? subDepartmentName;
  int? parentDepartmentId;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  CompanySubDepartment({
    this.subDeptId,
    this.companyId,
    this.subDepartmentName,
    this.parentDepartmentId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  @override
  String toString() {
    return 'SubDepartment(subDeptId: $subDeptId, companyId: $companyId, subDepartmentName: $subDepartmentName, parentDepartmentId: $parentDepartmentId, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  factory CompanySubDepartment.fromJson(Map<String, dynamic> json) => CompanySubDepartment(
    subDeptId: json['sub_dept_id'] as int?,
    companyId: json['company_id'] as int?,
    subDepartmentName: json['sub_department_name'] as String?,
    parentDepartmentId: json['parent_department_id'] as int?,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
    deletedAt: json['deleted_at'] as dynamic,
  );

  Map<String, dynamic> toJson() => {
    'sub_dept_id': subDeptId,
    'company_id': companyId,
    'sub_department_name': subDepartmentName,
    'parent_department_id': parentDepartmentId,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'deleted_at': deletedAt,
  };

  CompanySubDepartment copyWith({
    int? subDeptId,
    int? companyId,
    String? subDepartmentName,
    int? parentDepartmentId,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
  }) {
    return CompanySubDepartment(
      subDeptId: subDeptId ?? this.subDeptId,
      companyId: companyId ?? this.companyId,
      subDepartmentName: subDepartmentName ?? this.subDepartmentName,
      parentDepartmentId: parentDepartmentId ?? this.parentDepartmentId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}
