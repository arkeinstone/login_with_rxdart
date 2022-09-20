import 'dart:async';

class LoginValidator{
  final emailValidate = StreamTransformer<String, String>.fromHandlers(handleData: (email, sink){
    RegExp regExp = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if(regExp.hasMatch(email)){
      sink.add(email);
    }else{
      sink.addError('Email is not valid');
    }
  });

  final passwordValidate = StreamTransformer<String, String>.fromHandlers(handleData: (password, sink){
    RegExp regExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if(regExp.hasMatch(password) && password.length >= 8){
      sink.add("password");
    }else if(password.length < 8){
      sink.addError('Password must contain at least 8 characters');
    }else{
      sink.addError('Password must contain at least 1 special character, 1 number, 1 uppercase, 1 lowercase');
    }
  });
}