import 'package:meta/meta.dart';

@immutable
class LoginState {
  final bool isSuccess;
  final bool isFailure;

  LoginState({
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory LoginState.empty() {
    return LoginState(
      isSuccess: false,
      isFailure: false,
    );
  }

  factory LoginState.failure() {
    return LoginState(
      isSuccess: false,
      isFailure: true,
    );
  }

  factory LoginState.success() {
    return LoginState(
      isSuccess: true,
      isFailure: false,
    );
  }

  @override
  String toString() {
    return '''LoginState {
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
