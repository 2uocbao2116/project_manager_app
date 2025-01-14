import 'package:equatable/equatable.dart';

class SignInEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInInitialEvent extends SignInEvent {
  @override
  List<Object?> get props => [];
}

class SignInSubmitted extends SignInEvent {
  final String username;
  final String password;

  SignInSubmitted({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

// ignore: must_be_immutable
class FetchSignInEvent extends SignInEvent {
  FetchSignInEvent(
      {this.onFetchSignInEventSuccess, this.onFetchSignInEventError});

  Function? onFetchSignInEventSuccess;
  Function? onFetchSignInEventError;

  @override
  List<Object?> get props =>
      [onFetchSignInEventSuccess, onFetchSignInEventError];
}

class SignInByGoogle extends SignInEvent {
  @override
  List<Object?> get props => [];
}

class SignInByFaceBook extends SignInEvent {
  @override
  List<Object?> get props => [];
}
