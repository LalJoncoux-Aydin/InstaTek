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
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 8),
              child: const Text("Download Apk", style: TextStyle(color: blueColor)),
            ),
            GestureDetector(
              onTap: () => downloadFile("/build/app/outputs/flutter-apk/app-release.apk"),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: const Text("APK", style: TextStyle(fontWeight: FontWeight.bold, color: blueColor)),
              ),
            )
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
