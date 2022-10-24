import 'dart:html';
import 'package:flutter/material.dart';
import 'package:instatek/methods/auth_methods.dart';
import 'package:instatek/screens/register_screen.dart';
import 'package:instatek/utils/colors.dart';
import '../layout/mobile_screen_layout.dart';
import '../layout/responsive_layout_screen.dart';
import '../layout/web_screen_layout.dart';
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
      password = newPassword;
    });
  }

  void updateInput(dynamic value, dynamic typeInput) {
    if (typeInput == 1) {
      updateEmail(value);
    } else if (typeInput == 2) {
      updatePassword(value);
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
            buildTextFormField('Enter your email prod', _emailController, false, emailIsValid(email), 1),
            buildTextFormField('Enter your password', _passwordController, true, passwordIsValid(password), 2),
            buildErrorText(errorText),
            _buildButton('Login', formKey),
            Flexible(flex: 2, child: Container()),
            _buildDownloadApk(),
            _buildNavLink("Don't have an account ?", "Register"),
          ],
        ),
      ),
    );
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

  String? passwordIsValid(dynamic value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  void loginUser(dynamic formKey) async {
    if (formKey.currentState!.validate()) {

      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      // set loading to true
      setState(() {
        _isLoading = true;
      });

      // signup user using our auth method
      final String res = await AuthMethods().loginUser(
        email: _emailController.text,
        password: _passwordController.text,
      );

      setState(() {
        _isLoading = false;
      });
      // if string returned is success, user has been created
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
        // show the error
/*        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: CustomSnackBarContent(errorText: "Your credentials are not matching."),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
          )
        );*/
      }
    } else {
      setState(() {
        errorText = "";
      });
    }
  }
  Widget _buildButton(dynamic displayTxt, dynamic formKey) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 10),
        InkWell(
          onTap: () => loginUser(formKey),
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
            child: !_isLoading ? Text(displayTxt, style: TextStyle(color: whiteColor)) : CircularProgressIndicator(color: primaryColor),
          ),
        ),
      ],
    );
  }

  downloadFile(dynamic url) {
    final AnchorElement anchorElement = AnchorElement(href: url);
    anchorElement.download = "Instatek-V1.apk";
    anchorElement.click();
  }

  Widget _buildDownloadApk() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 8),
              child: Text("Donwload Apk", style: TextStyle(color: blueColor)),
            ),
            GestureDetector(
                onTap: () => downloadFile("/build/app/outputs/flutter-apk/app-release.apk"),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Text("APK", style: TextStyle(fontWeight: FontWeight.bold, color: blueColor)),
                ),)
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  void navigateToRegister() {
    Navigator.of(context).push(MaterialPageRoute<dynamic>(builder: (BuildContext context) => const RegisterScreen()));
  }
  Widget _buildNavLink(dynamic displayText1, dynamic displayText2) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 8),
              child: Text(displayText1, style: TextStyle(color: blueColor)),
            ),
            GestureDetector(
                onTap: navigateToRegister,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Text(displayText2,
                      style: TextStyle(fontWeight: FontWeight.bold, color: blueColor),),
                ),)
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
