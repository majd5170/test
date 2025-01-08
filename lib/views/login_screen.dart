// import 'package:apitest/cubit_login/login_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class LoginScreen extends StatelessWidget {
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Login')),
//       body: BlocProvider(
//         create: (context) => LoginCubit(),
//         child: BlocListener<LoginCubit, LoginState>(
//           listener: (context, state) {
//             if (state is LoginSuccess) {
//               // Handle successful login
//               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                 content: Text('Login Successful! Token: ${state.token}'),
//               ));
//             } else if (state is LoginFailure) {
//               // Handle login failure
//               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                 content: Text('Login Failed: ${state.error}'),
//               ));
//             } else if (state is DataSuccess) {
//               // Handle successful data fetch
//               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// content: Text('Data Fetched Successfully! Data: ${state.data}'),
//               ));
//             } else if (state is DataFailure) {
//               // Handle data fetch failure
//               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                 content: Text('Data Fetch Failed: ${state.error}'),
//               ));
//             }
//           },
//           child: BlocBuilder<LoginCubit, LoginState>(
//             builder: (context, state) {
//               if (state is LoginLoading || state is DataLoading) {
//                 return Center(child: CircularProgressIndicator());
//               }
//               return Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     TextField(
//                       controller: usernameController,
//                       decoration: InputDecoration(labelText: 'Username'),
//                     ),
//                     TextField(
//                       controller: passwordController,
//                       decoration: InputDecoration(labelText: 'Password'),
//                       obscureText: true,
//                     ),
//                     SizedBox(height: 16),
//                     ElevatedButton(
//                       onPressed: () {
//                         final username = usernameController.text;
//                         final password = passwordController.text;
//                         context.read<LoginCubit>().login(username, password);
//                       },
//                       child: Text('Login'),
//                     ),
//                     SizedBox(height: 16),
//                     ElevatedButton(
//                       onPressed: () {
//                         context.read<LoginCubit>().fetchData();
//                       },
//                       child: Text('Fetch Data'),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:apitest/cubit_login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data_screen.dart'; // تأكد من استيراد الصفحة الجديدة

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              // Navigate to DataScreen after successful login
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DataScreen()),
              );
            } else if (state is LoginFailure) {
              // Handle login failure
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Login Failed: ${state.error}'),
              ));
            }
          },
          child: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              if (state is LoginLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(labelText: 'Username'),
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        final username = usernameController.text;
                        final password = passwordController.text;
                        context.read<LoginCubit>().login(username, password);
                      },
                      child: Text('Login'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}