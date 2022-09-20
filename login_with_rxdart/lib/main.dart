import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_with_rxdart/blocs/login/login_bloc.dart';
import 'package:login_with_rxdart/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: MaterialApp(
        title: 'Login with RxDart',
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}

