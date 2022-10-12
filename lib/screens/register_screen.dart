import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instatek/screens/login_screen.dart';
import 'package:instatek/screens/register_screen2.dart';
import 'package:instatek/utils/colors.dart';
import '../widgets/header_login_register.dart';
import '../widgets/text_field_input.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();

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

  Widget _buildBodyContainer() {
    // For the spacing
    var size = MediaQuery
        .of(context)
        .size;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      width: double.infinity,
      child: Column(
        children: [
          const HeaderLoginRegister(),
          TextFieldInput(hintText: 'Enter your email', textEditingController: _emailController, isPass: false),
          TextFieldInput(hintText: 'Enter your password', textEditingController: _passwordController, isPass: true),
          TextFieldInput(hintText: 'Enter your password again', textEditingController: _passwordController2, isPass: true),
          _buildButton('Register'),
          _buildNavLink("Already have an account ?", "Login"),
        ],
      ),
    );
  }

  void nextStepRegister() async {
    // if string returned is success, user has been created
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => RegisterScreen2(
            emailController: _emailController,
            passwordController: _passwordController
        ),
      ),
    );
  }
  Widget _buildButton(displayTxt) {
    return Column(
      children: [
        const SizedBox(height: 25),
        InkWell(
          onTap: () => nextStepRegister(),
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
