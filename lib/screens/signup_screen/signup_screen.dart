// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:kwale/models/user_model/UserInfoModel.dart';
import 'package:kwale/screens/login_screen/login_screen.dart';
import 'package:kwale/screens/signup_screen/signup_widget/signup_widget.dart';
import 'package:kwale/screens/signup_screen/vendor_signup.dart';
import 'package:kwale/screens/signup_screen/verification_screen.dart';
import 'package:kwale/screens/widgets_screens/flutter_toast.dart';
import 'package:email_validator/email_validator.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'dart:math';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../widgets_screens/http_link.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final SignupWidget signupWidget = SignupWidget();
  final fetchInfo info = fetchInfo();

  void fieldClears(){
    _emailController.clear();
    _userNameController.clear();
    _passwordController.clear();
  }
  File? _userImage;
  String email = '';
  bool _isEmailValid = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _userImage = File(pickedImage.path);
      });
    }
  }

  bool isValidEmail(String email) {
    // Simple email validation using regular expression
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void validateEmail(String value) {
    if (!isValidEmail(value)) {
      setState(() {
        _isEmailValid = false;
      });
    } else {
      setState(() {
        _isEmailValid = true;
      });
    }
  }

  bool _obscurePassword = true;
  String _selectedCountryCode = '+260'; // Default country code

  bool _isCodeSent = false;
  String _verificationCode = '';
  String? pass;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              const SizedBox(
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 54,
                    backgroundImage: AssetImage('assets/images/logo/Kwale-logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          'Create Account',
                          style: TextStyle(
                            //color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Signup to get started!',
                          style: TextStyle(
                            //color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 30),
                    //username
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xffF8F8FF),
                      ),
                      child: TextField(
                        cursorColor: Colors.black,
                        controller: _userNameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          //prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    //Email
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xffF8F8FF),
                      ),
                      child: TextFormField(
                        controller: _emailController,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!_isEmailValid) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: const TextStyle(color: Colors.black),
                          //prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    //upload image
                    Container(
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xffF8F8FF),
                      ),
                      child: InternationalPhoneNumberInput(
                        searchBoxDecoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red, width: 2.0),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        onInputChanged: (PhoneNumber number) {
                          _phoneController.text = number.phoneNumber.toString();
                        },
                        selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.DIALOG,
                        ),
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.disabled,
                        selectorTextStyle: const TextStyle(color: Colors.black),
                        initialValue: PhoneNumber(
                          dialCode: _selectedCountryCode,
                          isoCode: 'ZM',
                        ),
                        textStyle: const TextStyle(fontSize: 16.0),
                        cursorColor: Colors.black,
                        inputDecoration: InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle: const TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        //if only the selected countries shown in drop down
                        countries: const ['ZM','PK'], // Add other country codes as needed
                        // onChanged: (PhoneNumber number) {
                        //   print(number.phoneNumber);
                        // },
                        onSaved: (PhoneNumber number) {
                          print('Country code: ${number.dialCode}');
                          print('Phone number: ${number.phoneNumber}');

                        },

                      ),
                    ),
                    const SizedBox(height: 20),
                    //date of birth & Upload image fields
                    // Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(12),
                    //     color: const Color(0xffF8F8FF),
                    //   ),
                    //   child: TextFormField(
                    //     controller: _dateController,
                    //     cursorColor: Colors.black,
                    //     decoration: InputDecoration(
                    //       labelText: 'Date of birth',
                    //       labelStyle: const TextStyle(color: Colors.black),
                    //       //prefixIcon: const Icon(Icons.date_range,color: Colors.black,),
                    //       border: OutlineInputBorder(
                    //         borderSide: BorderSide.none,
                    //         borderRadius: BorderRadius.circular(12),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 20),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(12),
                    //     color: const Color(0xffF8F8FF),
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Expanded(
                    //         child: Text(
                    //           _userImage?.path.toString() ?? "",
                    //           textAlign: TextAlign.start,
                    //         ),
                    //       ),
                    //       ElevatedButton(
                    //         onPressed: () {
                    //           _pickImage();
                    //         },
                    //         style: ElevatedButton.styleFrom(
                    //             backgroundColor: Colors.transparent),
                    //         child: Text("Upload Image"),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xffF8F8FF),
                      ),
                      child: TextFormField(
                        cursorColor: Colors.black,
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        validator: (val){
                          if (val!.length< 6){
                            pass = 'Incorrect';
                          }
                          else{
                            pass = 'correct';
                          }
                          return val!.length < 6 ? 'Minimum character length is 8' : null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return ScaleTransition(
                                  scale: animation,
                                  child: child,
                                );
                              },
                              child: _obscurePassword
                                  ? const Icon(
                                      Icons.visibility_off,
                                      key: ValueKey('visibility_off'),
                                      color: Colors.black,
                                    )
                                  : const Icon(
                                      Icons.visibility,
                                      key: ValueKey('visibility'),
                                      color: Colors.black,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    //Signup button
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          // Add your login logic here
                          // final form = Form.of(context);
                          //     if (form.validate()) {
                          //       form.save();
                          //       // Add your signup logic here
                          //     }
                          if(_userNameController.text.isNotEmpty &&
                              _emailController.text.isNotEmpty &&
                              _passwordController.text.isNotEmpty)
                          {
                            String username = _userNameController.text;
                            String email = _emailController.text;
                            String password = _passwordController.text;
                            //var code = await signupWidget.sendVerificationCode(_emailController.text);//_sendVerificationCode();
                            //fieldClears();
                            if(_passwordController.text.length>=6) {
                              var code = await signupWidget.sendVerificationCode(_emailController.text);//_sendVerificationCode();
                              Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VerificationCodeScreen(
                                  code: code,
                                  username: username,
                                  email: email,
                                  password: password,
                                  phone: _phoneController.text,
                                  date: _dateController.text,
                                  image: _userImage?.path,
                                  type: 'user',
                                ),
                              ),
                            );
                            }
                            else{
                              FlutterToast.showToast('Please enter valid password');
                            }
                          }
                          else {
                            FlutterToast.showToast('Please fill the Required Fields');
                          }
                          //registerUser();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          backgroundColor: Colors.red,
                        ),
                        child: const Text(
                          'Signup',
                        ),
                      ),
                    ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     // Validate and submit the form
                    //     final form = Form.of(context);
                    //     if (form.validate()) {
                    //       form.save();
                    //       // Add your signup logic here
                    //     }
                    //   },
                    //   child: const Text('Signup'),
                    // ),

                    const SizedBox(height: 10),
                    //Skip and Continue
                    // TextButton(
                    //   onPressed: () {
                    //     // Add your forgot password logic here
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => const VendorSignup(),
                    //       ),
                    //     );
                    //   },
                    //   style: TextButton.styleFrom(),
                    //   child: const Text(
                    //     'Become a Vendor?',
                    //     style: TextStyle(color: Colors.red),
                    //   ),
                    // ),
                    //Signup
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
                        "Already have an account? Login",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
