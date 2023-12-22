// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pavlok/cubits/stimuli/cubit/stimulus_cubit.dart';
import 'package:pavlok/cubits/user/cubit/user_cubit.dart';
import 'package:pavlok/models/userModel.dart';
import 'package:pavlok/screens/SignIn/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
        builder: (context) => BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is UserLoadedState) {
                  return HomeScreen();
                } else {
                  return LoginScreen();
                }
              },
            ),
        settings: RouteSettings(name: routeName));
  }

  TextEditingController typeController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Expanded(
              child: SvgPicture.asset(
                'assets/logo2.svg',
                height: 50,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                'PAVLOK',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_on_outlined,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.person_outline_rounded,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: BlocProvider(
        create: (context) => StimulusCubit(),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'USER STIMULUS',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  IconButton(
                    icon: Icon(Icons.add_circle),
                    onPressed: () {
                      Navigator.pushNamed(context, '/create');
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              BlocBuilder<UserCubit, UserState>(
                builder: (context, userState) {
                  if (userState is UserLoadedState) {
                    context
                        .read<StimulusCubit>()
                        .performStimuliAction(FetchStimuliEvent());
                  }

                  return BlocBuilder<StimulusCubit, StimulusState>(
                    builder: (context, state) {
                      if (state is StimulusLoading) {
                        return CircularProgressIndicator();
                      } else if (state is StimulusLoaded) {
                        return Expanded(
                          child: ListView.builder(
                              itemCount: state.stimulusList.length,
                              itemBuilder: (context, index) => stimulusTile(
                                    title: state.stimulusList[index].type,
                                    reason: state.stimulusList[index].reason ??
                                        'No reason',
                                    value: state.stimulusList[index].value
                                        .toString(),
                                  )),
                        );
                      } else if (state is StimulusError) {
                        print(state.message);
                        return Text(state.message);
                      } else {
                        print(state.toString());
                        return Text('No Stimulus to show at the moment.');
                      }

                      /*  return ListView(
                                                  children: [
                                                    stimulusTile(
                                                      icon: Icons.favorite,
                                                      title: 'Beep',
                                                      reason: 'Reason',
                                                    ),
                                                    stimulusTile(
                                                      icon: Icons.favorite,
                                                      title: 'Beep',
                                                      reason: 'Reason',
                                                    ),
                                                    stimulusTile(
                                                      icon: Icons.favorite,
                                                      title: 'Beep',
                                                      reason: 'Reason',
                                                    )
                                                  ],
                                                ); */
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class stimulusTile extends StatelessWidget {
  final String title;
  final String reason;
  final String value;

  const stimulusTile(
      {super.key,
      required this.title,
      required this.reason,
      required this.value});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    if (title == 'beep') {
      icon = Icons.notifications_active;
    } else if (this.title == 'vibe') {
      icon = Icons.vibration;
    } else if (this.title == 'zap') {
      icon = Icons.flash_on;
    } else {
      icon = Icons.favorite;
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          leading: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(12)),
              child: Icon(
                icon,
                color: Theme.of(context).cardColor,
              )),
          title: Text('$title - $value %'),
          subtitle: Text('$reason'),
          trailing: Icon(
            Icons.delete,
            color: Theme.of(context).primaryColorDark,
          ),
        ),
      ),
    );
  }
}
