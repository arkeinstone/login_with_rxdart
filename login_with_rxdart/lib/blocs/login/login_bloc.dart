import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_with_rxdart/validators/login_validator.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> with LoginValidator{
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  LoginBloc() : super(LoginInitialState()) {
    on<PressLoginButtonEvent>(_onPressLoginButtonEvent);
  }

  void _onPressLoginButtonEvent(PressLoginButtonEvent event, Emitter<LoginState> emit){
    emit(LoginLoadingState());
    if(event.email == 'abc@gmail.com' && event.password == 'An@123456'){
      emit(LoginSuccessState());
    }else{
      emit(LoginFailedState());
    }
  }

  Stream<String> get email => _email.stream.transform(emailValidate);
  Stream<String> get password => _password.stream.transform(passwordValidate);
  Function(String) get emailChange => _email.sink.add;
  Function(String) get passwordChange => _password.sink.add;
  Stream<bool> get submitValid => Rx.combineLatest2(email, password, (a, b) => true);
}
