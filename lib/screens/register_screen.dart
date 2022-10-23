import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:instatek/screens/login_screen.dart';
import 'package:instatek/screens/register_screen2.dart';
import 'package:instatek/utils/colors.dart';
import '../methods/auth_methods.dart';
import '../widgets/header_login_register.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();
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
    return Scaffold(
        body: SafeArea(
            child: Container(
                child: _buildBodyContainer(),),
        ),);
  }

  void updateEmail(dynamic newMail) {
    setState(() {
      email = newMail;
    });
  }

  void updatePassword(dynamic newPassword) {
    setState(() {
      password1 = newPassword;
    });
  }

  void updatePassword2(dynamic newPassword) {
    setState(() {
      password2 = newPassword;
    });
  }

  void updateInput(dynamic value, dynamic typeInput) {
    if (typeInput == 1) {
      updateEmail(value);
    } else if (typeInput == 2) {
      updatePassword(value);
    } else if (typeInput == 3) {
      updatePassword2(value);
    }
  }

  Column buildTextFormField(dynamic hintText, dynamic textEditingController, dynamic isPass, dynamic isValid, dynamic typeInput) {
    final OutlineInputBorder inputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context, color: blueColor),
    );

    return Column(
      children: <Widget>[
        const SizedBox(height: 10),
        TextFormField(
          validator: (String? value) {
            return isValid;
          },
          controller: textEditingController,
          onChanged: (String changedText) => updateInput(changedText, typeInput),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 15, color: blueColor),
            border: inputBorder,
            focusedBorder: inputBorder,
            enabledBorder: inputBorder,
            filled: true,
            contentPadding: const EdgeInsets.all(20),
          ),
          keyboardType: TextInputType.text,
          obscureText: isPass,
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Column buildErrorText(dynamic value) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 10),
        Text(value),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildBodyContainer() {
    // For the spacing
    /*var size = MediaQuery
        .of(context)
        .size;*/


    return Form(
      key: formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Flexible(flex: 2, child: Container()),
            const HeaderLoginRegister(),
            buildTextFormField('Enter your email', _emailController, false, emailIsValid(email), 1),
            buildTextFormField('Enter your password', _passwordController, true, passwordIsValid(password1), 2),
            buildTextFormField('Enter your password again', _passwordController2, true, password2IsValid(password1, password2), 3),
            buildErrorText(errorText),
            _buildButton('Register', formKey),
            Flexible(flex: 2, child: Container()),
            _buildNavLink("Already have an account ?", "Login"),
          ],
        ),
      ),
    );
  }

  String? emailIsValid(dynamic value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return 'Please enter an email in the correct format';
    }
    return null;
  }

  String? passwordIsValid(dynamic value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)) {
      return 'Please enter a password with 8 characters length - 1 letters in Upper Case - 1 Special Character (!@#\$&*) - 1 numerals (0-9)';
    }
    return null;
  }

  String? password2IsValid(dynamic pass1, dynamic pass2) {
    if (pass2 == null || pass2.isEmpty) {
      return 'Please enter some text';
    } else if (pass1 != pass2) {
      return 'Please rewrite your password identically';
    }
    return null;
  }

  void nextStepRegister(dynamic formKey) async {
    if (formKey.currentState!.validate()) {
      if (await AuthMethods().emailDoesntExist(_emailController.text)) {
        setState(() {
          errorText = "Email is already in use by another account";
        });
        return;
      }

      // Go to second page of Register
      await Navigator.of(context).pushReplacement(
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

  Widget _buildButton(dynamic displayTxt, dynamic formKey) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 25),
        InkWell(
          onTap: () => nextStepRegister(formKey),
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: ShapeDecoration(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4),),
              ),
              color: blueColor,
            ),
            child: Text(displayTxt, style: TextStyle(color: whiteColor)),
          ),
        ),
      ],
    );
  }

  void navigateToLogin() {
    Navigator.of(context).push(MaterialPageRoute<dynamic>(builder: (BuildContext context) => const LoginScreen()));
  }
  Widget _buildNavLink(dynamic displayText1, dynamic displayText2) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 41, horizontal: 8),
              child: Text(displayText1, style: TextStyle(color: blueColor)),
            ),
            GestureDetector(
                onTap: navigateToLogin,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(displayText2,
                      style: TextStyle(fontWeight: FontWeight.bold, color: blueColor),),
                ),)
          ],
        )
      ],
    );
  }
}
