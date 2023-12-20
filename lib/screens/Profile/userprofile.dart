// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pavlok/cubits/user/cubit/user_cubit.dart';
import 'package:pavlok/models/userModel.dart';

class EditUserInfo extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  static const String routeName = '/profile';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => EditUserInfo(),
        settings: RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    context.read<UserCubit>().performUserAction(GetUserEvent());
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(16.0),
      child: BlocBuilder<UserCubit, UserState>(
        builder: ((context, state) {
          if (state is UserInfoLoadedState) {
            return _buildUserForm(context, state.user);
          } else if (state is UserLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: Text('Something went wrong!'));
          }
        }),
      ),
    ));
  }

  Widget _buildUserForm(BuildContext context, User user) {
    emailController.text = user.email ?? "";
    usernameController.text = user.username ?? "";
    firstNameController.text = user.firstName ?? "";
    lastNameController.text = user.lastName ?? "";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('USER INFO', style: Theme.of(context).textTheme.displayMedium),
        SizedBox(
          height: 16.0,
        ),
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16.0),
        TextFormField(
          controller: usernameController,
          decoration: InputDecoration(
            labelText: 'Username',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16.0),
        TextFormField(
          controller: firstNameController,
          decoration: InputDecoration(
            labelText: 'First Name',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16.0),
        TextFormField(
          controller: lastNameController,
          decoration: InputDecoration(
            labelText: 'Last Name',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            String email = emailController.text;
            String username = usernameController.text;
            String firstName = firstNameController.text;
            String lastName = lastNameController.text;
          },
          child: Text('Submit'),
        ),
      ],
    );
  }
}
