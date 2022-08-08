import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/features/auth/controller/auth_controller.dart';

import '../../../colors.dart';

class OtpScreen extends ConsumerWidget {
  static const String routeName = '/otp-screen';
  final String verificationId;
  const OtpScreen({Key? key, required this.verificationId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0.0,
        title: const Text('Verifying your number'),
      ),
      body: Center(
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          const Text("We have sent an SMS with a code"),
          SizedBox(
            width: size.width * 0.5,
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              onChanged: ((value) {
                if (value.length == 6) {
                  ref
                      .read(authControllerProvider)
                      .verifyOTP(context, verificationId, value);
                }
              }),
              decoration: const InputDecoration(
                  hintText: "- - - - - -", hintStyle: TextStyle(fontSize: 30)),
            ),
          )
        ]),
      ),
    );
  }
}
