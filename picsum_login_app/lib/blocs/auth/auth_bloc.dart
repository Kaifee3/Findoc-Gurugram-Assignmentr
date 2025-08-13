import 'package:bloc/bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<AuthEmailChanged>(_onEmailChanged);
    on<AuthPasswordChanged>(_onPasswordChanged);
    on<AuthSubmitted>(_onSubmitted);
  }

  static final RegExp _emailRegExp = RegExp(
    r"^[\w\-.]+@([\w\-]+\.)+[\w\-]{2,4}$",
  );

  static final RegExp _passwordUpper = RegExp(r'[A-Z]');
  static final RegExp _passwordLower = RegExp(r'[a-z]');
  static final RegExp _passwordDigit = RegExp(r'\d');

  static final RegExp _passwordSymbol = RegExp(
    r'''[!@#\$%\^&\*\(\)_\+\-=\[\]\{\};:'",.<>\/\?\\|`~]''',
  );

  void _onEmailChanged(AuthEmailChanged event, Emitter<AuthState> emit) {
    final valid = _emailRegExp.hasMatch(event.email.trim());
    emit(state.copyWith(email: event.email, isEmailValid: valid));
  }

  void _onPasswordChanged(AuthPasswordChanged event, Emitter<AuthState> emit) {
    final pwd = event.password;
    final valid = _isPasswordValid(pwd);
    emit(state.copyWith(password: pwd, isPasswordValid: valid));
  }

  Future<void> _onSubmitted(AuthSubmitted event, Emitter<AuthState> emit) async {
    final isEmailValid = _emailRegExp.hasMatch(state.email.trim());
    final isPasswordValid = _isPasswordValid(state.password);

    if (!isEmailValid || !isPasswordValid) {
      emit(state.copyWith(
        isEmailValid: isEmailValid,
        isPasswordValid: isPasswordValid,
        errorMessage: 'Please correct the errors and try again.',
      ));
      return;
    }

    emit(state.copyWith(submissionInProgress: true, errorMessage: null));

    await Future.delayed(const Duration(milliseconds: 800));

    emit(state.copyWith(submissionInProgress: false, submissionSuccess: true));
  }

  bool _isPasswordValid(String pwd) {
    return pwd.length >= 8 &&
        _passwordUpper.hasMatch(pwd) &&
        _passwordLower.hasMatch(pwd) &&
        _passwordDigit.hasMatch(pwd) &&
        _passwordSymbol.hasMatch(pwd);
  }
}
