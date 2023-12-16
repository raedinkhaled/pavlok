import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pavlok/utils/colors.dart';
import 'package:pavlok/utils/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailCont = TextEditingController();
    TextEditingController passwordCont = TextEditingController();

    FocusNode emailfocus = FocusNode();
    FocusNode passwordfocus = FocusNode();

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      child: Scaffold(
        backgroundColor: scaffoldBackgroundColor,
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(24.0),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: "By signing in, you agree to TERMS AND CONDITIONS ",
                style: TextStyle(color: scondaryTextColor)),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sign in to Pavlok',
                    style: boldTextStyle,
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  TextFormField(
                    controller: emailCont,
                    textInputAction: TextInputAction.next,
                    focusNode: emailfocus,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(14),
                        child: FaIcon(
                          FontAwesomeIcons.at,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(
                          left: 16, right: 16, top: 8, bottom: 8),
                      filled: true,
                      fillColor: containerColor.withOpacity(0.1),
                      labelText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: passwordCont,
                    textInputAction: TextInputAction.send,
                    focusNode: passwordfocus,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(14),
                        child: FaIcon(
                          FontAwesomeIcons.lock,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(
                          left: 16, right: 16, top: 8, bottom: 8),
                      filled: true,
                      fillColor: containerColor.withOpacity(0.1),
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
