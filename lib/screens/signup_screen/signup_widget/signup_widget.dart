import 'dart:math';

import 'package:email_validator/email_validator.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import '../../widgets_screens/flutter_toast.dart';

class SignupWidget{
  String _verificationCode = '';
  bool _isCodeSent = false;
  Future<String> sendVerificationCode(email) async {
    // const String email =
    //     'muhammad.abdullah@oomi.co.uk'; //_emailController.text.trim();

    if (EmailValidator.validate(email)) {
      // Generate a verification code
      _verificationCode = _generateVerificationCode();

      // Replace with your email configuration
      final smtpServer = SmtpServer(
        'smtp.gmail.com',
        username: 'm8432917@gmail.com',
        password: 'huqhtrdnedlchpwo',
        port: 465,
        ssl: true,
      );

      // Create the email message
      final message = Message()
        ..from = const Address('muhammad.abdullah@oomi.co.uk', 'kwale')
        ..recipients.add(email)
        ..subject = 'Your Verification Code'
        ..text = 'Your verification code is $_verificationCode';

      try {
        // Send the email
        final sendReport = await send(message, smtpServer);

        if (sendReport.mail.text!.contains("$_verificationCode")) {
          FlutterToast.showToast(
            'Verification code sent to $email',
          );

          if (sendReport.mail.text == '123456') {
            print(sendReport.mail.text);
          }

          //setState(() {
            _isCodeSent = true;
          return _verificationCode;
         // });
        } else {
          print("hell ${sendReport.mail}");
          FlutterToast.showToast(
              'Failed to send verification code${sendReport.mail}');
          return "";
        }
      } catch (e) {
        FlutterToast.showToast('Failed to send verification code: $e');
        print("eexss $e");
        return "";
      }
    } else {
      FlutterToast.showToast('Please enter a valid email address');
      return "";
    }
  }

  String _generateVerificationCode() {
    // Generate a random verification code here
    // You can use a package like 'random_string' for this
    var no = 100000 + Random().nextInt(900000);
    return no.toString(); // Replace with your own code generation logic
  }
}