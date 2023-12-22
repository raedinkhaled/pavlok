// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pavlok/cubits/user/cubit/user_cubit.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  static const String routeName = '/signup';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => SignupScreen(),
        settings: RouteSettings(name: routeName));
  }

  void _onRegisterButtonPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<UserCubit>().performUserAction(
            RegisterEvent(_emailController.text.toString(),
                _passwordController.text.toString()),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/logo2.svg',
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(height: 16),
                  Text('PAVLOK',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 32),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.mail),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 32),
                  Align(
                    child: SizedBox(
                      width: double.infinity,
                      child: BlocConsumer<UserCubit, UserState>(
                        listener: (context, state) {
                          if (state is UserLoadedState) {
                            Navigator.popAndPushNamed(context, '/');
                          } else if (state is UserErrorState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.error)),
                            );
                          }
                        },
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: () => _onRegisterButtonPressed(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                            child: state is UserLoadingState
                                ? CircularProgressIndicator()
                                : Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        color: Theme.of(context).cardColor),
                                  ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(context, '/login');
                      },
                      child: Text('Already have an account? Log in'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
