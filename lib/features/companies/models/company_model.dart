class CompanyModel {
  int? id;
  int? userId;
  String? companyName;
  String? tradeLicenseNumber;
  String? abbr;
  String? incoporationDate;
  String? websiteUrl;
  int? parentCompany;
  String? businessActivities;
  int? empCount;
  String? createdAt;
  String? updatedAt;

  CompanyModel({
    this.id,
    this.userId,
    this.companyName,
    this.tradeLicenseNumber,
    this.abbr,
    this.incoporationDate,
    this.websiteUrl,
    this.parentCompany,
    this.businessActivities,
    this.empCount,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'CompanyModel(id: $id, userId: $userId, companyName: $companyName, tradeLicenseNumber: $tradeLicenseNumber, abbr: $abbr, incoporationDate: $incoporationDate, websiteUrl: $websiteUrl, parentCompany: $parentCompany, businessActivities: $businessActivities, empCount: $empCount, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
    id: json['id'] as int?,
    userId: json['user_id'] as int?,
    companyName: json['company_name'] as String?,
    tradeLicenseNumber: json['trade_license_number'] as String?,
    abbr: json['abbr'] as String?,
    incoporationDate: json['incoporation_date'] as String?,
    websiteUrl: json['website_url'] as String?,
    parentCompany: json['parent_company'] as int?,
    businessActivities: json['business_activities'] as String?,
    empCount: json['emp_count'] as int?,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
  );

  Map<String, dynamic> toJson() => {
    // 'id': id,
    'user_id': userId,
    'company_name': companyName,
    'trade_license_number': tradeLicenseNumber,
    'abbr': abbr,
    'incoporation_date': incoporationDate,
    'website_url': websiteUrl,
    'parent_company': parentCompany,
    'business_activities': businessActivities == null ? [] : businessActivities!.split(','),
    // 'created_at': createdAt,
    // 'updated_at': updatedAt,
  };

  CompanyModel copyWith({
    int? id,
    int? userId,
    String? companyName,
    String? tradeLicenseNumber,
    String? abbr,
    String? incoporationDate,
    String? websiteUrl,
    int? parentCompany,
    String? businessActivities,
    String? createdAt,
    String? updatedAt,
  }) {
    return CompanyModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      companyName: companyName ?? this.companyName,
      tradeLicenseNumber: tradeLicenseNumber ?? this.tradeLicenseNumber,
      abbr: abbr ?? this.abbr,
      incoporationDate: incoporationDate ?? this.incoporationDate,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      parentCompany: parentCompany ?? this.parentCompany,
      businessActivities: businessActivities ?? this.businessActivities,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
