import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pavlok/cubits/user/cubit/user_cubit.dart'; // Import the flutter_svg package

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  static const String routeName = '/login';
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => LoginScreen(),
        settings: RouteSettings(name: routeName));
  }

  void _onLoginButtonPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<UserCubit>().performUserAction(
            LoginEvent(_emailController.text.toString(),
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
                    height: 100,
                  ),
                  SizedBox(height: 16),
                  const Text('PAVLOK',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 32),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
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
                            onPressed: () => _onLoginButtonPressed(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                            child: state is UserLoadingState
                                ? CircularProgressIndicator()
                                : Text(
                                    'Sign In',
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
                        Navigator.popAndPushNamed(context, '/signup');
                      },
                      child: Text('Don\'t have an account? Sign up'),
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
