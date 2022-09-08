import 'dart:io';

import 'package:enough_giphy_flutter/enough_giphy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

const profileUrl =
    "https://firebasestorage.googleapis.com/v0/b/whatsappclone-ede88.appspot.com/o/avatar.png?alt=media&token=fbc76b2a-a8ae-4561-89b3-b6255e3a2ef8";

void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

Future<File?> pickImageFromGallery(BuildContext context) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    showSnackbar(context, e.toString());
  }
  return image;
}

Future<File?> pickVideoFromGallery(BuildContext context) async {
  File? video;
  try {
    final pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      video = File(pickedVideo.path);
    }
  } catch (e) {
    showSnackbar(context, e.toString());
  }
  return video;
}

Future<GiphyGif?> pickGif(BuildContext context) async {
  String apiKey = "UZRJAueKTThRwV1SxTUGoNsjIrUWZSE9";

  GiphyGif? giphyGif;

  try {
    giphyGif = await Giphy.getGif(context: context, apiKey: apiKey);
  } catch (e) {
    showSnackbar(context, e.toString());
  }

  return giphyGif;
}
