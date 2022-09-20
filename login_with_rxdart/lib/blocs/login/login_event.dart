part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class PressLoginButtonEvent extends LoginEvent{
  final String email;
  final String password;
  PressLoginButtonEvent({required this.email, required this.password});
}
