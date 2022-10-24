import 'package:flutter/material.dart';
import 'package:instatek/methods/auth_methods.dart';
import 'package:instatek/screens/register_screen.dart';
import 'package:instatek/widgets/custom_download_apk_widget.dart';
import 'package:instatek/widgets/custom_error_text_widget.dart';

import '../layout/mobile_screen_layout.dart';
import '../layout/responsive_layout_screen.dart';
import '../layout/web_screen_layout.dart';
import '../widgets/custom_nav_link_widget.dart';
import '../widgets/custom_text_form_field_widget.dart';
import '../widgets/custom_validation_button.dart';
import '../widgets/header_login_register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  late String email = "";
  late String password = "";
  late String errorText = "";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*var size = MediaQuery
        .of(context)
        .size;*/

    return Scaffold(
        body: SafeArea(
          child: Form(
            key: formKey,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Flexible(flex: 2, child: Container()),
                  const HeaderLoginRegister(),
                  CustomTextFormField(hintText: 'Enter your email', textEditingController: _emailController, isPass: false, isValid: emailIsValid(email), updateInput: updateEmail),
                  CustomTextFormField(hintText: 'Enter your password', textEditingController: _passwordController, isPass: true, isValid: passwordIsValid(password), updateInput: updatePassword),
                  CustomErrorText(displayStr: errorText),
                  CustomValidationButton(displayText: 'Login', formKey: formKey, loadingState: _isLoading, onTapFunction: loginUser),
                  Flexible(flex: 2, child: Container()),
                  const CustomDownloadApk(),
                  CustomNavLink(displayText1: "Don't have an account ?", displayText2: "Register", onTapFunction: navigateToRegister),
                ],
              ),
            ),
          ),
        ),
    );
  }

  void updateEmail(dynamic newMail) {
    setState(() {
      email = newMail;
    });
  }
  String? emailIsValid(dynamic value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return 'Please enter an email in the correct format';
    }
    return null;
  }

  void updatePassword(dynamic newPassword) {
    setState(() {
      password = newPassword;
    });
  }
  String? passwordIsValid(dynamic value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  void loginUser(dynamic formKey) async {
    if (formKey.currentState!.validate()) {

      setState(() {
        _isLoading = true;
      });
      final String res = await AuthMethods().loginUser(
        email: _emailController.text,
        password: _passwordController.text,
      );
      setState(() {
        _isLoading = false;
      });

      // if res is Success, go to next page
      if (res == "Success") {
      await Navigator.of(context).push(
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
          ),
        );
      }
      else if (res == "user-not-found" || res == "wrong-password") {
        setState(() {
          errorText = "Your credentials are not matching.";
        });
      }
      else {
        setState(() {
          errorText = "A server error happened : $res";
        });
      }
    } else {
      setState(() {
        errorText = "";
      });
    }
  }

  void navigateToRegister() {
    Navigator.of(context).push(MaterialPageRoute<dynamic>(builder: (BuildContext context) => const RegisterScreen()));
  }
}
