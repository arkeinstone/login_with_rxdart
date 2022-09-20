import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_with_rxdart/blocs/login/login_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  late LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state){
            if(state is LoginSuccessState){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Success')));
            }else if(state is LoginFailedState){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Failed')));
            }
          },
          builder: (context, state){
            if(state is LoginLoadingState){
              return const Center(child: CircularProgressIndicator(),);
            }else{
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder(
                    stream: _loginBloc.email,
                    builder: (context, snapshot){
                      return TextField(
                        controller: _emailController,
                        onChanged: _loginBloc.emailChange,
                        decoration: InputDecoration(
                          errorText: snapshot.error != null ? snapshot.error.toString() : null,
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          errorBorder: snapshot.error != null ? const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(style: BorderStyle.solid, color: Colors.red,),
                          ) : null,
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(style: BorderStyle.solid, color: Colors.black,),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(style: BorderStyle.solid, color: Colors.black,)
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10,),
                  StreamBuilder<String>(
                    stream: _loginBloc.password,
                    builder: (context, snapshot){
                      return TextField(
                        controller: _passwordController,
                        onChanged: _loginBloc.passwordChange,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          errorText: snapshot.hasError ? snapshot.error.toString() : null,
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(style: BorderStyle.solid, color: Colors.black,),
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(style: BorderStyle.solid, color: Colors.black,)
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                              borderSide:const BorderSide(style: BorderStyle.solid, color: Colors.white,)
                          )
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10,),
                  MaterialButton(
                    onPressed: (){
                      _loginBloc.add(PressLoginButtonEvent(email: _emailController.text, password: _passwordController.text));
                    },
                    minWidth: MediaQuery.of(context).size.width - 100,
                    height: 50,
                    color: Colors.black,
                    child: const Text('Login', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

