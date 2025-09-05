class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final bool emailVerified;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.emailVerified,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      emailVerified: json['emailVerified'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'role': role,
      'emailVerified': emailVerified,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class AuthResponse {
  final String accessToken;
  final String refreshToken;
  final User user;

  AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'user': user.toJson(),
    };
  }
}

class SignupRequest {
  final String firstName;
  final String lastName;
  final String email;

  SignupRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory SignupRequest.fromJson(Map<String, dynamic> json) {
    return SignupRequest(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
  }
}

class VerifyOtpRequest {
  final String email;
  final String otp;
  final String password;

  VerifyOtpRequest({
    required this.email,
    required this.otp,
    required this.password,
  });

  factory VerifyOtpRequest.fromJson(Map<String, dynamic> json) {
    return VerifyOtpRequest(
      email: json['email'] as String,
      otp: json['otp'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'otp': otp,
      'password': password,
    };
  }
}

class SigninRequest {
  final String email;
  final String password;

  SigninRequest({
    required this.email,
    required this.password,
  });

  factory SigninRequest.fromJson(Map<String, dynamic> json) {
    return SigninRequest(
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
