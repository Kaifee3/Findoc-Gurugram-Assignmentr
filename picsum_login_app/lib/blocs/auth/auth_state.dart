import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final String email;
  final String password;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool submissionInProgress;
  final bool submissionSuccess;
  final String? errorMessage;

  const AuthState({
    this.email = '',
    this.password = '',
    this.isEmailValid = false,
    this.isPasswordValid = false,
    this.submissionInProgress = false,
    this.submissionSuccess = false,
    this.errorMessage,
  });

  AuthState copyWith({
    String? email,
    String? password,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? submissionInProgress,
    bool? submissionSuccess,
    String? errorMessage,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      submissionInProgress: submissionInProgress ?? this.submissionInProgress,
      submissionSuccess: submissionSuccess ?? this.submissionSuccess,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        isEmailValid,
        isPasswordValid,
        submissionInProgress,
        submissionSuccess,
        errorMessage
      ];
}
