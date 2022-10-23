//import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:instatek/providers/user_provider.dart';
//import 'package:instatek/screens/login_screen.dart';
import 'package:instatek/utils/colors.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:instatek/widgets/header_login_register.dart';
import '../home/mobile_screen_layout.dart';
import '../home/responsive_layout_screen.dart';
import '../home/web_screen_layout.dart';
import '../methods/auth_methods.dart';
import '../utils/utils.dart';

class RegisterScreen2 extends StatefulWidget {
  const RegisterScreen2({Key? key, required this.emailController, required this.passwordController}) : super(key: key);
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<RegisterScreen2> createState() => _RegisterScreenState2();
}

class _RegisterScreenState2 extends State<RegisterScreen2> {
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;
  late String username = "";
  late String errorText = "";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                child: _buildBodyContainer(),),
        ),);
  }

  void updateUsername(dynamic newUsername) {
    setState(() {
      username = newUsername;
    });
  }

  void updateInput(dynamic value, dynamic typeInput) {
    if (typeInput == 1) {
      updateUsername(value);
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
      children: <Widget> [
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
            const HeaderLoginRegister(),
            _buildImageInput(),
            buildTextFormField('Enter your username', _usernameController, false, usernameIsValid(username), 1),
            buildTextFormField('Enter your bio', _bioController, false, null, 0),
            buildErrorText(errorText),
            _buildButton('Register', formKey),
          ],
        ),
      ),
    );
  }

  String? usernameIsValid(dynamic value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    // If username is not in the db
    return null;
  }

  void selectImage() async {
   final Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }
  Widget _buildImageInput() {
    return Column(
      children: <Widget>[
        // image input
        const SizedBox(height: 10),
        Stack(
          children: <Widget>[
            if (_image != null) CircleAvatar(
              radius: 64,
              backgroundImage: MemoryImage(_image!),
              backgroundColor: Colors.red,
            ) else const CircleAvatar(
              radius: 64,
              backgroundImage: NetworkImage(
                  'https://cdn-icons-png.flaticon.com/512/847/847969.png',),
              // backgroundColor: Colors.red,
            ),
            Positioned(
              bottom: -10,
              left: 80,
              child: IconButton(
                onPressed: selectImage,
                icon: const Icon(
                    Icons.add_a_photo,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  void registerUser(dynamic formKey) async {
    if (formKey.currentState!.validate()) {
      // set loading to true
      setState(() {
        _isLoading = true;
      });

      // signup user using our auth method
      final String res = await AuthMethods().registerUser(
        email: widget.emailController.text,
        password: widget.passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        profilePicture : _image,
      );

      setState(() {
        _isLoading = false;
      });
      // if string returned is success, user has been created
      if (res == "Success") {
        await Navigator.of(context).pushReplacement(
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
          ),
        );
      }
      else if (res == 'username-already-in-use') {
        setState(() {
          errorText = "Username is already in use by another account";
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
  Widget _buildButton(dynamic displayTxt, dynamic formKey) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 25),
        InkWell(
          onTap: () => registerUser(formKey),
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
}
