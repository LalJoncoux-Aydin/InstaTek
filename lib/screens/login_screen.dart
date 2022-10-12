import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instatek/resources/auth_methods.dart';
import 'package:instatek/screens/login_screen.dart';
import 'package:instatek/screens/register_screen.dart';
import 'package:instatek/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/utils.dart';
import '../widgets/header_login_register.dart';
import '../widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
          Flexible(flex: 2, child: Container()),
          const HeaderLoginRegister(),
          TextFieldInput(hintText: 'Enter your email', textEditingController: _emailController, isPass: false),
          TextFieldInput(hintText: 'Enter your password', textEditingController: _passwordController, isPass: false),
          _buildButton('Login'),
          Flexible(flex: 2, child: Container()),
          _buildNavLink("Don't have an account ?", "Register"),
        ],
      ),
    );
  }

  void loginUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our auth method
    String res = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });
    // if string returned is success, user has been created
    if (res == "Success") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      // show the error
      showSnackBar(context, res);
    }
  }
  Widget _buildButton(displayTxt) {
    return Column(
      children: [
        const SizedBox(height: 10),
        InkWell(
          onTap: () => loginUser(),
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
            child: !_isLoading ? Text(displayTxt, style: const TextStyle(color: whiteColor)) : const CircularProgressIndicator(color: primaryColor),
          ),
        ),
      ],
    );
  }

  void navigateToRegister() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegisterScreen()));
  }
  Widget _buildNavLink(displayText1, displayText2) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 8),
              child: Text(displayText1, style: const TextStyle(color: blueColor)),
            ),
            GestureDetector(
                onTap: navigateToRegister,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Text(displayText2,
                      style: const TextStyle(fontWeight: FontWeight.bold, color: blueColor)),
                ))
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
