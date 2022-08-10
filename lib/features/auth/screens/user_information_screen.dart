import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/common/utils/utils.dart';
import 'package:whatsapp_ui/features/auth/controller/auth_controller.dart';

class UserInformationScreen extends ConsumerStatefulWidget {
  static const String routeName = '/user_information_screen';
  const UserInformationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UserInformationScreen> createState() =>
      _UserInformationScreenState();
}

class _UserInformationScreenState extends ConsumerState<UserInformationScreen> {
  final TextEditingController _nameController = TextEditingController();
  File? image;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(children: [
          Stack(
            children: [
              image == null
                  ? const CircleAvatar(
                      radius: 64,
                      backgroundImage: AssetImage("assets/avatar.png"))
                  : CircleAvatar(
                      radius: 64, backgroundImage: FileImage(image!)),
              Positioned(
                  bottom: -10,
                  right: 0,
                  child: IconButton(
                      onPressed: () {
                        selectImage(context);
                      },
                      icon: const Icon(Icons.add_a_photo)))
            ],
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                width: size.width * 0.85,
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      hintText: "Enter your name",
                      hintStyle: TextStyle(fontSize: 20)),
                ),
              ),
              IconButton(
                  onPressed: () {
                    storeUserData();
                  },
                  icon: const Icon(Icons.done))
            ],
          )
        ]),
      )),
    );
  }

  void selectImage(BuildContext context) async {
    setState(() async {
      image = await pickImageFromGallery(context);
    });
  }

  void storeUserData() async {
    String name = _nameController.text.trim();
    if (name.isNotEmpty) {
      ref.read(authControllerProvider).saveUserDataToFirebase(
          context: context, name: name, profipic: image);
    }
  }
}
