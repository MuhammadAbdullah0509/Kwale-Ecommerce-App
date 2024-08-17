import 'package:flutter/material.dart';
import 'package:kwale/screens/login_screen/change_password.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../signup_screen/signup_widget/signup_widget.dart';
import '../widgets_screens/flutter_toast.dart';
import 'login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final SignupWidget signupWidget = SignupWidget();
  bool show = false;
  late String no = '';
  var code;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            // Perform search action
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Forgot Password',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [Color(0xFF66BB6A), Color(0xFF43A047)],
          // ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Please enter your email here!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: const TextStyle(color: Colors.white),
                    filled: true,
                    //fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  //style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async{
                    code = await signupWidget.sendVerificationCode(_emailController.text);
                    Future.delayed(const Duration(seconds: 3), () {
                      // After the splash screen duration, navigate to the main screen or any other screen
                      show = true;
                      setState(() {});
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    // color: Colors.white,
                    // textColor: Colors.green,
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Reset Password',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Go back to Login',
                    style: TextStyle(color: Colors.red),
                  ),
                ),

                const SizedBox(height: 20.0),
                show==true?buildField(context):const SizedBox(height: 0.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildField(context){
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30.0),
            const Text(
              'Enter the verification code sent to your email',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 30.0),
            PinCodeTextField(
              appContext: context,
              length: 6,
              obscureText: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5.0),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.white,
                activeColor: Colors.blue[800],
                inactiveColor: Colors.blue[200],
                selectedColor: Colors.blue[800],
              ),
              cursorColor: Colors.blue[800],
              //controller: textEditingController,
              onChanged: (value) {
                // Verify the code automatically
                // if (value.length == 6) {
                //   _verifyCode(value);
                // }
              },
              onCompleted: (value) {
                //_verifyCode(value);
                no = value;
              },
            ),
            const SizedBox(height: 30.0),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: () async{
                  // Add your login logic here
                  verifyCode(no);

                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  backgroundColor: Colors.red,
                ),
                child: const Text('Verify',),
              ),
            ),
            const SizedBox(height: 30.0),
            TextButton(
              onPressed: () {
                // Add your forgot password logic here
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: const Text(
                "Don't have code? Resend it",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  verifyCode(String c) async {
    //print(code);
    //print(widget.code);
    print(c);
    if(code == c){
      Navigator.push(context, MaterialPageRoute(builder: (context) =>
          ChangePasswordScreen(email: _emailController.text,)
        ,),
      );
      print("verified");
    }
    else {
      FlutterToast.showToast('Invalid code. Please check the code and try again.');
    }
  }
}
