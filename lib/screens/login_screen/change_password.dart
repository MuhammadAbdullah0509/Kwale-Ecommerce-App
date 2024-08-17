// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kwale/models/user_model/UpdateUserModel.dart';
import 'package:http/http.dart' as http;

import '../widgets_screens/flutter_toast.dart';
import '../widgets_screens/http_link.dart';
import 'login_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  String? email;
  ChangePasswordScreen({super.key, this.email});

  @override
  ChangePasswordScreenState createState() => ChangePasswordScreenState();
}

class ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _newPassword = true;
  bool _obscurePassword = true;
  final UpdateUser user = UpdateUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          'Change Password',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(12),
              //     color: const Color(0xffF8F8FF),
              //   ),
              //   child: TextFormField(
              //     controller: _oldPasswordController,
              //     obscureText: _newPassword,
              //     decoration: InputDecoration(
              //       labelText: 'New Password',
              //       labelStyle: const TextStyle(
              //         color: Colors.black,
              //       ),
              //       border: OutlineInputBorder(
              //         borderSide: BorderSide.none,
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //       suffixIcon: GestureDetector(
              //         onTap: () {
              //           setState(() {
              //             _newPassword = !_newPassword;
              //           });
              //         },
              //         child: AnimatedSwitcher(
              //           duration: const Duration(milliseconds: 200),
              //           transitionBuilder:
              //               (Widget child, Animation<double> animation) {
              //             return ScaleTransition(
              //               scale: animation,
              //               child: child,
              //             );
              //           },
              //           child: _newPassword
              //               ? const Icon(
              //             Icons.visibility_off,
              //             key: ValueKey('visibility_off'),
              //             color: Colors.black,
              //           )
              //               : const Icon(
              //             Icons.visibility,
              //             key: ValueKey('visibility'),
              //             color: Colors.black,
              //           ),
              //         ),
              //       ),
              //     ),
              //     validator: (value) {
              //       if (value!.isEmpty) {
              //         return 'Please enter a new password';
              //       }
              //       // Add your password validation logic here if needed
              //       return null;
              //     },
              //   ),
              // ),
              const SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xffF8F8FF),
                ),
                child: TextFormField(
                  controller: _newPasswordController,
                  obscureText: _newPassword,
                    decoration: InputDecoration(
                      labelText: 'New Password',
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
                            _newPassword = !_newPassword;
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
                          child: _newPassword
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a new password';
                    }
                    // Add your password validation logic here if needed
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xffF8F8FF),
                ),
                child: TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Confirm New Password',
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please confirm your new password';
                    }
                    if (value != _newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 30.0),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async{
                    // Add your login logic here
                    if (_formKey.currentState!.validate()) {
                      // Add your password change logic here
                      // For this example, let's just print a message
                      await updateUserPassword(widget.email, _confirmPasswordController.text);
                      print('Password changed successfully');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Save',),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> updateUserPassword(email,pass) async
  {
    print("email${widget.email}");
    var response = await http.post(Uri.parse("${APILink.link}Registration/updatePassword."),
      body: ({
        "email": email.toString(),
        "password": pass.toString(),
      }),
    );
    if(response.statusCode == 200)
    {
      FlutterToast.showToast('Your password has been updated Successfully');
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (BuildContext context) {
            return const LoginScreen();
          }), (r) {
            return false;
          });
      //await _fetchInfo.fetchUsers(email);
    }
    else {
      FlutterToast.showToast('Something went wrong please try again');
    }
  }
}
