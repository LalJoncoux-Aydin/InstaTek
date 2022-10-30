import 'package:flutter/cupertino.dart';
import 'package:instatek/widgets/custom_validation_button.dart';
import 'custom_profile_picture_profile.dart';
import 'custom_table_profile_follow.dart';

class CustomInfobarProfile extends StatelessWidget {
  const CustomInfobarProfile({Key? key, required this.photoUrl, required this.followers, required this.following, required this.postSize, required this.username, required this.bio, required this.formKey}) : super(key: key);

  final String photoUrl;
  final int followers;
  final int following;
  final int postSize;
  final String username;
  final String bio;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    const double paddingHeader = 10;
    final Size size = MediaQuery.of(context).size;
    double paddingGlobal = 0;
    double paddingTopName = 0;
    double paddingTopBio = 0;
    if (size.width >= 1366) {
      paddingGlobal = 10;
    } else {
      paddingGlobal = 10;
      paddingTopName = 10;
      paddingTopBio = 1;
    }

    return Column(
      children: <Container>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: paddingHeader),
          width: double.infinity,
          child: Row(
            children: <Widget>[
              CustomProfilePictureProfile(photoUrl: photoUrl),
              CustomTableProfileFollow(followers: followers, following: following, postSize: postSize),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: paddingGlobal),
          width: double.infinity,
          child: Column(
            children: <Container>[
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: paddingTopName),
                child: Text(
                  username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: paddingTopBio),
                child: Text(
                  bio,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 5),
          width: double.infinity,
          child: Form(
            key: formKey,
            child: CustomValidationButton(displayText: "Modify my account", formKey: formKey, loadingState: false, onTapFunction: modifyAccount),
          ),
        )
      ],
    );
  }

  void modifyAccount(dynamic formKey) async {

  }
}
