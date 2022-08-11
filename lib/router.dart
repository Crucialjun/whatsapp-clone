import 'package:flutter/material.dart';
import 'package:whatsapp_ui/common/widgets/error.dart';
import 'package:whatsapp_ui/features/auth/screens/login_screen.dart';
import 'package:whatsapp_ui/features/auth/screens/otp_screen.dart';
import 'package:whatsapp_ui/features/auth/screens/user_information_screen.dart';
import 'package:whatsapp_ui/features/select_contacts/screens/select_contacts_screen.dart';
import 'package:whatsapp_ui/screens/mobile_chat_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    case UserInformationScreen.routeName:
      return MaterialPageRoute(builder: (_) => const UserInformationScreen());
    case OtpScreen.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(
          builder: (_) => OtpScreen(
                verificationId: verificationId,
              ));
    case SelectContactsScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SelectContactsScreen());
    case MobileChatScreen.routeName:
      return MaterialPageRoute(builder: (_) => const MobileChatScreen());
    default:
      return MaterialPageRoute(
          builder: (_) => const ErrorScreen(error: "This page does not exist"));
  }
}
