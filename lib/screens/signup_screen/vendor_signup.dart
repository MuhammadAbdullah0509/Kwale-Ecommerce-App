// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:http/http.dart' as http;
import 'package:kwale/models/vendorModels/GetSpecificVendor.dart';
import 'package:kwale/screens/signup_screen/signup_widget/signup_widget.dart';
import 'package:kwale/screens/signup_screen/signup_widget/validEmail.dart';
import 'package:kwale/screens/signup_screen/verification_screen.dart';

import '../home_screen/home_screen.dart';
import '../vendor_screens/vendor_dashboard.dart';
import '../widgets_screens/flutter_toast.dart';
import '../widgets_screens/http_link.dart';

class VendorSignup extends StatefulWidget {
  const VendorSignup({super.key});

  @override
  _VendorSignupState createState() => _VendorSignupState();
}

class _VendorSignupState extends State<VendorSignup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = '';
  bool _isEmailValid = true;
  bool _obscurePassword = true;
  final String _selectedCountryCode = '+1'; // Default country code
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final GetVendor getVendor = GetVendor();
  final SignupWidget signupWidget = SignupWidget();
  File? _userImage;

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

  void _validateEmail(String value) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context); // Replace with desired action
          },
        ),
        title: const Text(
          'Sign Up Vendor',
          style: TextStyle(
              //color: Colors.white,
              fontSize: 24,
              color: Colors.black),
        ),
        centerTitle: true,
      ),
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
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
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Text(
                      'Signup to get started!',
                      style: TextStyle(
                        //color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 50),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xffF8F8FF),
                      ),
                      child: TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          //prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xffF8F8FF),
                      ),
                      child: TextFormField(
                        controller: _emailController,
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
                          //prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    //phone no field
                    Container(
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xffF8F8FF),
                      ),
                      child: InternationalPhoneNumberInput(
                        keyboardType: TextInputType.number,
                        onInputChanged: (PhoneNumber number) {
                          print(number.phoneNumber);
                          _phoneController.text = number.phoneNumber.toString();
                          print(_phoneController.text);
                        },
                        selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.DIALOG,
                        ),
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.disabled,
                        selectorTextStyle: const TextStyle(color: Colors.black),
                        initialValue: PhoneNumber(
                            //isoCode: 'US',
                            dialCode: _selectedCountryCode),
                        textStyle: const TextStyle(fontSize: 16.0),
                        inputDecoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        //if only the selected countries shown in drop down
                        //countries: const ['US', 'IN', 'GB'], // Add other country codes as needed
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
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xffF8F8FF),
                      ),
                      child: TextField(
                        controller: _dateController,
                        decoration: InputDecoration(
                          labelText: 'Date of birth',
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
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xffF8F8FF),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              _userImage?.path.toString() ?? "",
                              textAlign: TextAlign.start,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _pickImage();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent),
                            child: Text("Upload Image"),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    //password Textfield
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xffF8F8FF),
                      ),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
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
                         var code =  await signupWidget
                              .sendVerificationCode(_emailController.text);
                         print(code);
                         Navigator.push(context, MaterialPageRoute(builder: (context) => VerificationCodeScreen(
                            code: code,
                            username: _nameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                            phone: _phoneController.text,
                            image: _userImage!.path.toString(),
                            date: _dateController.text,
                            type: "vendor",),),
                         );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          backgroundColor: Colors.red,
                        ),
                        child: const Text(
                          'Sign Up Vendor',
                        ),
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

  Future<void> registerVendorUser() async {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty) {
      var response =
          await http.post(Uri.parse("${APILink.link}Registration/registerUser."),
              body: ({
                "email": _emailController.text,
                "username": _nameController.text,
                "password": _passwordController.text,
                "ID": 2.toString(),
              }));
      if (response.statusCode == 200) {
        await getVendor.addVendor(
          _emailController.text,
          _nameController.text,
          _phoneController.text,
         // _dateController.text,
          //_userImage?.path.toString(),
        );
      }
    }
  }
}
