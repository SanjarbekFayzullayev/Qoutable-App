import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';

class Method {
  //Save and Share Methode
  Future saveAndShare(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File("${directory.path}/quotable.png");
    image.writeAsBytes(bytes);
    await Share.shareFiles([image.path],
        text:
            "More quotes : https://play.google.com/store/apps/details?id=uz.muslimsoft.quotable.quotable_app");
  }

  //Save image to phone Methode
  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll(".", "-")
        .replaceAll(":", "-");
    final name = "QuoteApp$time";
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    return result("filePath");
  }

  //Show SnackBar Methode
  void showSnackBar(String meg, BuildContext context) {
    var snackBar = SnackBar(
      duration: const Duration(seconds: 4),
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.8,
          right: 20,
          left: 20),
      elevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.white,
      content: Text(
        meg,
        style: const TextStyle(
          color: Color(0xFF1F2A36),
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //Random image numbers Methode
  int getNumber() {
    var rng = Random();
    for (var i = 0; i < 10; i++) {
      return rng.nextInt(100);
    }
    return 500;
  }

  //image Methode
  NetworkImage getImage() {
    var rng = Random();
    return NetworkImage(
        "https://picsum.photos/300/880/?blur=1/image=${getNumber()}");
  }
}
