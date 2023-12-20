import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pavlok/cubits/user/cubit/user_cubit.dart';
import 'package:pavlok/screens/Home/home.dart';
import 'package:pavlok/screens/Profile/userprofile.dart';
import 'package:pavlok/screens/SignIn/signin.dart';
import 'package:pavlok/screens/SignUp/signup.dart';
import 'package:pavlok/screens/Stimulus/createStimulus.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('The Route is: ${settings.name}');

    switch (settings.name) {
      case '/':
        return HomeScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      case '/login':
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );
      case '/signup':
        return MaterialPageRoute(
          builder: (context) => SignupScreen(),
        );
      case '/create':
        return MaterialPageRoute(builder: (context) => CreateStimulusScreen());
      case '/profile':
        return MaterialPageRoute(builder: (context) => EditUserInfo());
      default:
        return _errorRoute();
    }
  }
}

Route _errorRoute() {
  return MaterialPageRoute(
      builder: (_) => Scaffold(
            appBar: AppBar(title: Text("Error")),
          ),
      settings: RouteSettings(name: '/error'));
}
