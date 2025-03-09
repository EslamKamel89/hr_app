class RegisterParams {
  String? name;
  String? email;
  String? password;
  int? levelId;

  RegisterParams({this.name, this.email, this.password, this.levelId});

  @override
  String toString() {
    return 'RegisterParams(name: $name, email: $email, password: $password, levelId: $levelId)';
  }

  factory RegisterParams.fromJson(Map<String, dynamic> json) {
    return RegisterParams(
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      levelId: json['level_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'password': password,
    'level_id': levelId,
  };

  RegisterParams copyWith({
    String? name,
    String? email,
    String? password,
    int? levelId,
  }) {
    return RegisterParams(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      levelId: levelId ?? this.levelId,
    );
  }
}
