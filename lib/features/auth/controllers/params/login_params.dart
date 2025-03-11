class LoginParams {
  String? email;
  String? password;

  LoginParams({this.email, this.password});

  @override
  String toString() {
    return 'LoginParams( email: $email, password: $password)';
  }

  factory LoginParams.fromJson(Map<String, dynamic> json) {
    return LoginParams(
      email: json['email'] as String?,
      password: json['password'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {'email': email, 'password': password};

  LoginParams copyWith({String? email, String? password}) {
    return LoginParams(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
