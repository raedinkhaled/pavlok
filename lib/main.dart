import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pavlok/cubits/user/cubit/user_cubit.dart';
import 'package:pavlok/screens/Home/home.dart';
import 'package:pavlok/utils/app_router.dart';
import 'package:pavlok/utils/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final UserCubit userCubit = UserCubit();
    return BlocProvider(
      create: (context) => userCubit..checkLoginStatus(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: theme(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: HomeScreen.routeName,
      ),
    );
  }
}
