import 'package:flutter/material.dart';

enum LoginStatus { initial, admLogin, employeeLogin, error }

class LoginState {
  final LoginStatus status;
  final String? errorMessage;

  LoginState({
    required this.status,
    this.errorMessage,
  });

  LoginState.initial() : this(status: LoginStatus.initial);

  LoginState copyWith({
    LoginStatus? status,
    ValueGetter<String?>? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }
}
