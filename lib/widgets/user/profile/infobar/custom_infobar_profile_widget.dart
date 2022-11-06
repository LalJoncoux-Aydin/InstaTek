import 'package:flutter/cupertino.dart';
import 'package:instatek/widgets/tools/custom_validation_button.dart';
import '../../../../utils/colors.dart';
import 'custom_name_profile_widget.dart';
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

  final ShapeDecoration modifyButton = const ShapeDecoration(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(4),
      ),
    ),
    color: greyColor,
  );

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double paddingGlobal = 0;
    double paddingImageTable = 0;
    double paddingName = 0;
    double paddingButtonTop = 0;
    double paddingButtonBottom = 0;
    if (size.width >= 1366) {
      paddingGlobal = 30;
      paddingImageTable = 10;
      paddingName = 10;
      paddingButtonTop = 1;
      paddingButtonBottom = 1;
    } else {
      paddingGlobal = 20;
      paddingImageTable = 2;
      paddingName = 15;
      paddingButtonTop = 20;
      paddingButtonBottom = 2;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: paddingGlobal),
      child: Column(
        children: <Container>[
          Container(
            padding: EdgeInsets.only(top: paddingImageTable),
            width: double.infinity,
            child: Row(
              children: <Widget>[
                CustomProfilePictureProfile(photoUrl: photoUrl),
                CustomTableProfileFollow(followers: followers, following: following, postSize: postSize),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: paddingName),
            width: double.infinity,
            child: CustomNameProfile(username: username, bio: bio),
          ),
          Container(
            padding: EdgeInsets.only(top: paddingButtonTop, bottom: paddingButtonBottom),
            width: double.infinity,
            child: Form(
              key: formKey,
              child: CustomValidationButton(displayText: "Modify my account", formKey: formKey, loadingState: false, onTapFunction: modifyAccount, shapeDecoration: modifyButton),
            ),
          )
        ],
      )
    );
  }

  void modifyAccount(dynamic formKey) async {

  }
}
