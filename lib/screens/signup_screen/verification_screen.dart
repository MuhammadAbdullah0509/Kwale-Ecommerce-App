// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kwale/models/user_model/UserInfoModel.dart';
import 'package:kwale/screens/vendor_screens/vendor_dashboard.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;

import '../../models/user_model/UserInfoModel.dart';
import '../../models/user_model/UserInfoModel.dart';
import '../../models/vendorModels/GetSpecificVendor.dart';
import '../login_screen/login_screen.dart';
import '../widgets_screens/flutter_toast.dart';
import '../widgets_screens/http_link.dart';

class VerificationCodeScreen extends StatefulWidget {
  String code;
  String username;
  String email;
  String password;
  String? type,date;
  String? phone,image;
  VerificationCodeScreen({super.key, required this.code, required this.username, required this.email, required this.password,
    required this.type, this.phone, this.image,this.date
  });

  @override
  _VerificationCodeScreenState createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  TextEditingController textEditingController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late String no = '';
  final GetVendor getVendor = GetVendor();
  final fetchInfo fetchUser = fetchInfo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
          'Verification Screen',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //   width: 200.0,
              //   height: 150.0,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     color: Colors.blue[800],
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.black.withOpacity(0.1),
              //         blurRadius: 10.0,
              //         offset: Offset(0, 5),
              //       ),
              //     ],
              //   ),
              //   child: Center(
              //     child: Text(
              //       'Logo',
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 24.0,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ),
              // ),
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
                controller: textEditingController,
                onChanged: (value) {
                  // Verify the code automatically
                  // if (value.length == 6) {
                  //   _verifyCode(value);
                  // }
                },
                onCompleted: (value) {
                 // _verifyCode(value);
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
                    _verifyCode(no);

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
      ),
    );
  }

   _verifyCode(String code) async {
    if(widget.code == code){
      if(widget.type == "vendor") {
        await registerVendorUser();
      }
      else {
        await registerUser();
      }
    }
    else {
     FlutterToast.showToast('Invalid code. Please check the code and try again.');
    }
  }

  //save User in DB
  Future<void> registerUser() async{
      if(widget.username.isNotEmpty && widget.email.isNotEmpty && widget.password.isNotEmpty)
    {
      var user = await http.post(Uri.parse('${APILink.link}Registration/registerUser'),
        body: ({
          "email": widget.email,
          "username": widget.username,
          "password": widget.password,
          "ID":"1"
        }),
      );
      if(user.statusCode == 200){
        await fetchUser.addUser(
            widget.email,
            widget.username,
            widget.phone,
            //widget.date,
            //widget.image,
        );
        FlutterToast.showToast('Your Account has been Created Successfully!');
        await getVendor.addVendor(
          widget.email,
          widget.username,
          widget.phone,
         // widget.date,
         // widget.image,
        );
        //Navigator.push(context, MaterialPageRoute(builder: (context) =>  const LoginScreen(),),);
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (BuildContext context) {
              return const LoginScreen();
            }), (r) {
              return false;
            });
      }
      else if(user.statusCode == 302){
        FlutterToast.showToast('This Email is already exist!');
      }
      else {
        print("status code: ${user.statusCode}");
        FlutterToast.showToast('Server Error! Please try again Thanks.${user.statusCode}');
      }
    }
    else {
      FlutterToast.showToast('Please fill all the fields!');
    }
  }
  //save vandor
  Future<void> registerVendorUser() async {
    print(widget.email.isNotEmpty);
    print(widget.password.isNotEmpty);
    print(widget.username.isNotEmpty);
    if (widget.email.isNotEmpty &&
        widget.password.isNotEmpty &&
        widget.username.isNotEmpty) {
      var response =
      await http.post(Uri.parse("${APILink.link}Registration/registerUser"),
          body: ({
            "email": widget.email,
            "username": widget.username,
            "password": widget.password,
            "ID": 2.toString(),
          }));
      if (response.statusCode == 200) {
        print(response.statusCode);
        await getVendor.addVendor(
          widget.email,
          widget.username,
          widget.phone,
          //widget.date,
          //widget.image,
        );
        // Navigator.pushAndRemoveUntil(context,
        //     MaterialPageRoute(builder: (BuildContext context) {
        //       return const LoginScreen();
        //     }), (r) {
        //       return false;
        //     });
      }
    }
  }
}

