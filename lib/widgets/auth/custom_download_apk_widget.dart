import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/colors.dart';

class CustomDownloadApk extends StatelessWidget {
  const CustomDownloadApk({Key? key}) : super(key: key);

  void downloadFile(dynamic url) async {
    await launchUrl(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double paddingVertical = 0;
    if (size.width >= 1366) {
      paddingVertical = 20;
    } else {
      paddingVertical = 20;
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: paddingVertical),
      child: GestureDetector(
        onTap: () => downloadFile("/build/app/outputs/flutter-apk/app-release.apk"),
        child: Text("Download APK", style: Theme.of(context).textTheme.subtitle2),
      ),
    );
  }
}
