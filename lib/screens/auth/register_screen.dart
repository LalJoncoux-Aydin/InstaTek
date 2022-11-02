import 'package:flutter/material.dart';
import 'package:instatek/screens/auth/login_screen.dart';
import 'package:instatek/screens/auth/register_screen2.dart';
import '../../methods/auth_methods.dart';
import '../../widgets/tools/custom_error_text_widget.dart';
import '../../widgets/auth/custom_nav_link_widget.dart';
import '../../widgets/tools/custom_text_form_field_widget.dart';
import '../../widgets/tools/custom_validation_button.dart';
import '../../widgets/auth/header_login_register.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();
  bool _isLoading = false;
  late String email = "";
  late String password1 = "";
  late String password2 = "";
  late String errorText = "";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordController2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double paddingGlobal = 0;
    if (size.width >= 1366) {
      paddingGlobal = 500;
    } else {
      paddingGlobal = 60;
    }

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: paddingGlobal),
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      const HeaderLoginRegister(),
                      CustomTextFormField(hintText: 'Enter your email', textEditingController: _emailController, isPass: false, isValid: emailIsValid(email), updateInput: updateEmail),
                      CustomTextFormField(hintText: 'Enter your password', textEditingController: _passwordController, isPass: true, isValid: passwordIsValid(password1), updateInput: updatePassword),
                      CustomTextFormField(hintText: 'Enter your password again', textEditingController: _passwordController2, isPass: true, isValid: password2IsValid(password1, password2), updateInput: updatePassword2),
                      CustomErrorText(displayStr: errorText),
                      CustomValidationButton(displayText: 'Register', formKey: formKey, loadingState: _isLoading, onTapFunction: nextStepRegister, shapeDecoration: null,),
                      CustomNavLink(displayText1: "Already have an account ?", displayText2: "Login", onTapFunction: navigateToLogin),
                    ],
                  ),
                ),
              ),
            )
          ],),
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
    } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return 'Please enter an email in the correct format';
    }
    return null;
  }

  void updatePassword(dynamic newPassword) {
    setState(() {
      password1 = newPassword;
    });
  }
  String? passwordIsValid(dynamic value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)) {
      return 'Please enter a password with 8 characters length - 1 letters in Upper Case - 1 Special Character (!@#\$&*) - 1 numerals (0-9)';
    }
    return null;
  }

  void updatePassword2(dynamic newPassword) {
    setState(() {
      password2 = newPassword;
    });
  }
  String? password2IsValid(dynamic pass1, dynamic pass2) {
    if (pass2 == null || pass2.isEmpty) {
      return 'Please enter some text';
    } else if (pass1 != pass2) {
      return 'Please rewrite your password identically';
    }
    return null;
  }

  void nextStepRegister(dynamic formKey, BuildContext? context) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      if (!await AuthMethods().emailDoesntExist(_emailController.text)) {
        setState(() {
          errorText = "Email is already in use by another account";
        });
        setState(() {
          _isLoading = false;
        });
        return;
      }
      setState(() {
        _isLoading = false;
      });

      if (!mounted) return;
      // Go to second page of Register
      await Navigator.of(context!).pushReplacement(
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) =>
              RegisterScreen2(
                  emailController: _emailController,
                  passwordController: _passwordController,
              ),
        ),
      );
    }
  }

  void navigateToLogin() {
    Navigator.of(context).push(MaterialPageRoute<dynamic>(builder: (BuildContext context) => const LoginScreen()));
  }
}
