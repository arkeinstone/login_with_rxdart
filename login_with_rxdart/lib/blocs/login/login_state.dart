part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable{
  @override
  List<Object?> get props => [];
}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState{}

class LoginSuccessState extends LoginState{}

class LoginFailedState extends LoginState{}
