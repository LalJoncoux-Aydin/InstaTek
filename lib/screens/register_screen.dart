import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final formKey = GlobalKey<FormState>();

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
                child: _buildBodyContainer())
        ));
  }

  void updateEmail(newMail) {
    setState(() {
      email = newMail;
    });
  }

  void updatePassword(newPassword) {
    setState(() {
      password1 = newPassword;
    });
  }

  void updatePassword2(newPassword) {
    setState(() {
      password2 = newPassword;
    });
  }

  void updateInput(value, typeInput) {
    if (typeInput == 1) {
      updateEmail(value);
    } else if (typeInput == 2) {
      updatePassword(value);
    } else if (typeInput == 3) {
      updatePassword2(value);
    }
  }

  Column buildTextFormField(hintText, textEditingController, isPass, isValid, typeInput) {
    final inputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context, color: blueColor)
    );

    return Column(
      children: [
        const SizedBox(height: 10),
        TextFormField(
          validator: (value) {
            return isValid;
          },
          controller: textEditingController,
          onChanged: (changedText) => updateInput(changedText, typeInput),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 15, color: blueColor),
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


  Column buildPasswordStrength() {
    double strength = 0.0;
    String type = "";

    if (RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(password1) == true) {
      //return 'Please enter a password with 8 characters length - 1 letters in Upper Case - 1 Special Character (!@#\$&*) - 1 numerals (0-9)';}
      strength = 3 / 3;
      type = "Your password is strong.";
    }
    if (RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z]).{8,}$').hasMatch(password1) == false) {
      strength = 2 / 3;
      type = "Your password is not strong enough.";
    }
    if (RegExp(r'^.{8,}$').hasMatch(password1) == false) {
      strength = 1 / 3;
      type = "Your password is not long enough.";
    }
    if (password1 == null || password1.isEmpty) {
      strength = 0.0;
      type = "";
    }

    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(type),
          ),
        ),
        const SizedBox(height: 10),
        LinearProgressIndicator(
          value: strength,
          backgroundColor: Colors.grey[300],
          color: strength <= 1 / 3
              ? Colors.red
              : strength == 2 / 3
              ? Colors.yellow
              : strength == 3 / 3
              ? Colors.green
              : Colors.transparent,
          minHeight: 5,
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Column buildErrorText(value) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Text(value),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildBodyContainer() {
    // For the spacing
    var size = MediaQuery
        .of(context)
        .size;


    return Form(
      key: formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        width: double.infinity,
        child: Column(
          children: [
            Flexible(flex: 2, child: Container()),
            const HeaderLoginRegister(),
            buildTextFormField('Enter your email', _emailController, false, emailIsValid(email), 1),
            buildTextFormField('Enter your password', _passwordController, true, passwordIsValid(password1), 2),
            buildPasswordStrength(),
            buildTextFormField('Enter your password again', _passwordController2, true, password2IsValid(password1, password2), 3),
            buildErrorText(errorText),
            _buildButton('Register', formKey),
            Flexible(flex: 2, child: Container()),
            _buildNavLink("Already have an account ?", "Login"),
          ],
        ),
      )
    );
  }

  String? emailIsValid(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return 'Please enter an email in the correct format';
    }
    return null;
  }
  String? passwordIsValid(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)) {
      return 'Please enter a password with 8 characters length - 1 letters in Upper Case - 1 Special Character (!@#\$&*) - 1 numerals (0-9)';
    }
    return null;
  }
  String? password2IsValid(pass1, pass2) {
    if (pass2 == null || pass2.isEmpty) {
      return 'Please enter some text';
    } else if (pass1 != pass2) {
      return 'Please rewrite your password identically';
    }
    return null;
  }

  void nextStepRegister(formKey) async {
    if (formKey.currentState!.validate()) {
      if (await AuthMethods().emailDoesntExist(_emailController.text)) {
        setState(() {
          errorText = "Email is already in use by another account";
        });
        return;
      }

      // Go to second page of Register
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              RegisterScreen2(
                  emailController: _emailController,
                  passwordController: _passwordController
              ),
        ),
      );
    }
  }
  Widget _buildButton(displayTxt, formKey) {
    return Column(
      children: [
        const SizedBox(height: 25),
        InkWell(
          onTap: () => nextStepRegister(formKey),
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4),),
              ),
              color: blueColor,
            ),
            child: Text(displayTxt, style: const TextStyle(color: whiteColor)),
          ),
        ),
      ],
    );
  }

  void navigateToLogin() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
  Widget _buildNavLink(displayText1, displayText2) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 41, horizontal: 8),
              child: Text(displayText1, style: const TextStyle(color: blueColor)),
            ),
            GestureDetector(
                onTap: navigateToLogin,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(displayText2,
                      style: const TextStyle(fontWeight: FontWeight.bold, color: blueColor)),
                ))
          ],
        )
      ],
    );
  }
}
