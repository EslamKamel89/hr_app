class CompanyModel {
  final int id;
  final String name;
  final int employeesCount;
  final DateTime createdAt;

  CompanyModel({
    required this.id,
    required this.name,
    required this.employeesCount,
    required this.createdAt,
  });
}
