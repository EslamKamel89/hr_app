class CompanyBankModel {
  int? id;
  String? bankNickName;
  String? bankName;
  String? bankAccountNumber;
  String? bankAccountIbanNumber;
  String? swiftCode;
  int? companyBasicId;
  String? createdAt;
  String? updatedAt;

  CompanyBankModel({
    this.id,
    this.bankNickName,
    this.bankName,
    this.bankAccountNumber,
    this.bankAccountIbanNumber,
    this.swiftCode,
    this.companyBasicId,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'CompanyBankModel(id: $id, bankNickName: $bankNickName, bankName: $bankName, bankAccountNumber: $bankAccountNumber, bankAccountIbanNumber: $bankAccountIbanNumber, swiftCode: $swiftCode, companyBasicId: $companyBasicId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory CompanyBankModel.fromJson(Map<String, dynamic> json) => CompanyBankModel(
    id: json['id'] as int?,
    bankNickName: json['bank_nick_name'] as String?,
    bankName: json['bank_name'] as String?,
    bankAccountNumber: json['bank_account_number'] as String?,
    bankAccountIbanNumber: json['bank_account_iban_number'] as String?,
    swiftCode: json['swift_code'] as String?,
    companyBasicId: json['company_basic_id'] as int?,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'bank_nick_name': bankNickName,
    'bank_name': bankName,
    'bank_account_number': bankAccountNumber,
    'bank_account_iban_number': bankAccountIbanNumber,
    'swift_code': swiftCode,
    'company_basic_id': companyBasicId,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };

  CompanyBankModel copyWith({
    int? id,
    String? bankNickName,
    String? bankName,
    String? bankAccountNumber,
    String? bankAccountIbanNumber,
    String? swiftCode,
    int? companyBasicId,
    String? createdAt,
    String? updatedAt,
  }) {
    return CompanyBankModel(
      id: id ?? this.id,
      bankNickName: bankNickName ?? this.bankNickName,
      bankName: bankName ?? this.bankName,
      bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
      bankAccountIbanNumber: bankAccountIbanNumber ?? this.bankAccountIbanNumber,
      swiftCode: swiftCode ?? this.swiftCode,
      companyBasicId: companyBasicId ?? this.companyBasicId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
