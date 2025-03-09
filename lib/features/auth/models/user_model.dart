class UserModel {
  String? name;
  String? email;
  int? levelId;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? accessToken;

  UserModel({
    this.name,
    this.email,
    this.levelId,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.accessToken,
  });

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, levelId: $levelId, updatedAt: $updatedAt, createdAt: $createdAt, id: $id, accessToken: $accessToken)';
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json['name'] as String?,
    email: json['email'] as String?,
    levelId: json['level_id'] as int?,
    updatedAt: json['updated_at'] as String?,
    createdAt: json['created_at'] as String?,
    id: json['id'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'level_id': levelId,
    'updated_at': updatedAt,
    'created_at': createdAt,
    'id': id,
  };

  UserModel copyWith({
    String? name,
    String? email,
    int? levelId,
    String? updatedAt,
    String? createdAt,
    int? id,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      levelId: levelId ?? this.levelId,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
    );
  }
}
