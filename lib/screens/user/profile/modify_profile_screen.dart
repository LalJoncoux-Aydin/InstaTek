import 'package:flutter/material.dart';
import 'package:instatek/models/user.dart' as model;
import 'package:provider/provider.dart';
import '../../../providers/user_provider.dart';
import '../../../widgets/tools/custom_loading_screen.dart';
import '../../../widgets/tools/custom_text_form_field_widget.dart';
import '../../../widgets/user/profile/infobar/custom_profile_picture_profile.dart';

class ModifyProfile extends StatefulWidget {
  const ModifyProfile({Key? key}) : super(key: key);

  @override
  State<ModifyProfile> createState() => _ModifyProfileState();
}

class _ModifyProfileState extends State<ModifyProfile> {
  late UserProvider userProvider;
  late model.User myUser;
  late String username = "";
  late String photoUrl;
  late String bio;
  bool _isLoading = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    setupUser();
  }

  void setupUser() async {
    userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
    if (userProvider.isUser == true) {
      setState(() {
        myUser = userProvider.getUser;
        username = myUser.username;
        bio = myUser.bio;
        photoUrl = myUser.avatarUrl;
        _isLoading = true;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;
    double paddingGlobal = 0;
    if (size.width >= 1366) {
      paddingGlobal = 500;
    } else {
      paddingGlobal = 60;
    }

    if (_isLoading == false) {
      setupUser();
      return const CustomLoadingScreen();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Modify profil",),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Form(
            key: formKey,
            child: Column(
              children: <Expanded>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: paddingGlobal),
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          CustomProfilePictureProfile(photoUrl: photoUrl),
                          const Text("Modify profil picture"),
                          CustomTextFormField(hintText: 'Enter your username',
                              textEditingController: _usernameController,
                              isPass: false,
                              isValid: usernameIsValid(username),
                              updateInput: updateUsername),
                          CustomTextFormField(hintText: 'Enter your bio',
                              textEditingController: _bioController,
                              isPass: true,
                              isValid: bioIsValid(bio),
                              updateInput: updateBio),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }

/*  void updateEmail(dynamic newMail) {
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
  }*/

  void updateUsername(dynamic newUsername) {
    setState(() {
      username = newUsername;
    });
  }
  String? usernameIsValid(dynamic value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  void updateBio(dynamic newBio) {
    setState(() {
      bio = newBio;
    });
  }
  String? bioIsValid(dynamic value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }
}
