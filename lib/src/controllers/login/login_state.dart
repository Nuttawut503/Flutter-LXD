import 'package:meta/meta.dart';

@immutable
class LoginState {
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  LoginState({
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory LoginState.empty() {
    return LoginState(
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory LoginState.submit() {
    return LoginState(
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory LoginState.success() {
    return LoginState(
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  factory LoginState.failure() {
    return LoginState(
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  @override
  String toString() {
    return '''LoginState {
      isSubmitting: $isSubmitting
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
