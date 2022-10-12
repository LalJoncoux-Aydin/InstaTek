import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instatek/resources/auth_methods.dart';
import 'package:instatek/screens/login_screen.dart';
import 'package:instatek/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/utils.dart';
import '../widgets/text_field_input.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void registerUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our auth method
    String res = await AuthMethods().registerUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        profilePicture : _image,
    );

    setState(() {
      _isLoading = false;
    });
    // if string returned is success, user has been created
    if (res == "Success") {
      Navigator.of(context).pushReplacement(
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

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void navigateToLogin() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
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
          _buildHeader(),
          _buildImageInput(),
          _buildInput('Enter your username', _usernameController, false),
          _buildInput('Enter your email', _emailController, false),
          _buildInput('Enter your password', _passwordController, true),
          _buildInput('Enter your bio', _bioController, false),
          _buildButton('Register'),
          _buildNavLink("Already have an account ?", "Login"),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const SizedBox(height: 30),
        SvgPicture.asset(
          'assets/instatek_logo.svg',
          height: 60,
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildImageInput() {
    return Column(
      children: [
        // image input
        const SizedBox(height: 10),
        Stack(
          children: [
            _image != null
                ? CircleAvatar(
              radius: 64,
              backgroundImage: MemoryImage(_image!),
              backgroundColor: Colors.red,
            )
                : const CircleAvatar(
              radius: 64,
              backgroundImage: NetworkImage(
                  'https://cdn-icons-png.flaticon.com/512/847/847969.png'),
              // backgroundColor: Colors.red,
            ),
            Positioned(
              bottom: -10,
              left: 80,
              child: IconButton(
                onPressed: selectImage,
                icon: const Icon(
                    Icons.add_a_photo
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildInput(displayTxt, controller, pw) {
    return Column(
      children: [
        const SizedBox(height: 10),
        TextFieldInput(
          hintText: displayTxt,
          textInputType: TextInputType.text,
          textEditingController: controller,
          isPass: pw,
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildButton(displayTxt) {
    return Column(
      children: [
        const SizedBox(height: 25),
        InkWell(
          onTap: () => registerUser(),
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
