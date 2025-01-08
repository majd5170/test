import 'package:apitest/cubit_login/login_cubit.dart';
import 'package:apitest/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Dio dio = Dio();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: MaterialApp(
        home: LoginScreen(),
      ),
    );
  }
}
