import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/colors.dart';
import 'package:whatsapp_ui/features/auth/controller/auth_controller.dart';

import '../../../common/widgets/custom_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  Country? _country;

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0.0,
        title: const Text('Enter your phone number'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(children: [
          const Text("Whatsapp will need to verify your phone number."),
          const SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () {
                pickCountry();
              },
              child: const Text("Pick Country")),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              _country != null
                  ? Text("+${_country!.phoneCode}")
                  : const SizedBox(),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: size.width * 0.7,
                child: TextField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    hintText: "phone number",
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: size.height * 0.55),
          SizedBox(
            width: 90,
            child: CustomButton(
              text: "NEXT",
              onPressed: () {
                sendPhoneNumber();
              },
            ),
          ),
        ]),
      ),
    );
  }

  void pickCountry() {
    showCountryPicker(
        context: context,
        onSelect: (Country country) {
          setState(() {
            _country = country;
          });
        });
  }

  void sendPhoneNumber() {
    String phoneNumber = _phoneController.text.trim();

    if (_country != null && phoneNumber.isNotEmpty) {
      ref
          .read(authControllerProvider)
          .signInWithPhone(context, "+${_country!.phoneCode}$phoneNumber");
    }
  }
}
