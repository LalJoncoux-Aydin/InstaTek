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
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text("Download Apk", style: Theme.of(context).textTheme.subtitle1),
            ),
            GestureDetector(
              onTap: () => downloadFile("/build/app/outputs/flutter-apk/app-release.apk"),
              child: Container(
                //padding: const EdgeInsets.symmetric(vertical: 25),
                child: Text("APK", style: Theme.of(context).textTheme.subtitle2),
              ),
            )
          ],
        ),
      //  const SizedBox(height: 24),
      ],
    );
  }
}
