part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final Map currentUser;

  const Authenticated(this.currentUser);

  @override
  List<Object> get props => [currentUser];

  @override
  String toString() {
    return '''Authenticated { 
      id: ${currentUser['id']}, 
      name: ${currentUser['name']}, 
      email: ${currentUser['email']},
      profile_picture_url: ${currentUser['profile_picture_url']}
    }\n''';
  }
}

class Unauthenticated extends AuthenticationState {}
