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

  @override
  Widget build(BuildContext context) {
    context.read<UserCubit>().performUserAction(GetUserEvent());
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(16.0),
      child: BlocBuilder<UserCubit, UserState>(
        builder: ((context, state) {
          if (state is UserLoadedState) {
            return _buildUserForm(context, state.user);
          } else if (state is UserLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else {
            // Handle error or other states
            return Center(child: Text('Something went wrong!'));
          }
        }),
      ),
    ));
  }

  Widget _buildUserForm(BuildContext context, User user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          initialValue: user.email,
          controller: emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16.0),
        TextFormField(
          initialValue: user.username,
          controller: usernameController,
          decoration: InputDecoration(
            labelText: 'Username',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16.0),
        TextFormField(
          initialValue: user.firstName,
          controller: firstNameController,
          decoration: InputDecoration(
            labelText: 'First Name',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16.0),
        TextFormField(
          initialValue: user.lastName,
          controller: lastNameController,
          decoration: InputDecoration(
            labelText: 'Last Name',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            // TODO: Implement submit functionality
            String email = emailController.text;
            String username = usernameController.text;
            String firstName = firstNameController.text;
            String lastName = lastNameController.text;
            // Perform the necessary actions with the updated user info
          },
          child: Text('Submit'),
        ),
      ],
    );
  }
}
