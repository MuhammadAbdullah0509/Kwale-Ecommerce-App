import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:kwale/models/user_model/UpdateUserModel.dart';
import 'package:kwale/models/user_model/UserInfoModel.dart';
import 'package:kwale/models/vendorModels/GetSpecificVendor.dart';
import 'package:kwale/screens/widgets_screens/flutter_toast.dart';
import 'package:kwale/screens/widgets_screens/http_link.dart';
import '../widgets_screens/bottom_nav_bar.dart';
import 'package:intl/intl.dart';

class VendorSetting extends StatefulWidget {
  String? image, userName,date;
  VendorSetting({super.key,this.image,this.userName,this.date});

  @override
  _VendorSettingState createState() => _VendorSettingState();
}

class _VendorSettingState extends State<VendorSetting> {
  final bool _obscurePassword = true;
  final bool changeFields = true;
  int _currentIndex = 0;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  //final TextEditingController _passwordController = TextEditingController();

  File? _userImage;
  var email;
  var phoneN0;
  var dOB;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _userImage = File(pickedImage.path);
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = APILink.googleEmail ?? fetchInfo.userEmail;
    phoneN0 = APILink.googlePhoneNO ?? fetchInfo.phoneNO;
    email!=null? _phoneNoController.text = phoneN0:"";
    email!=null?_emailController.text = email:'';
    dOB = fetchInfo.dateOfBirth;
    dOB!=null?_dobController.text = dOB:"";
    // print(_phoneNoController.text);
    // print("phone${phoneN0}");
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
        title: const Text('Account Information',style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
                        child:  SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              fetchInfo.image!=null || _userImage!=null?
                              CircleAvatar(
                                backgroundColor: const Color(0xffFFFFC2),
                                radius: 60,
                                backgroundImage: _userImage != null
                                    ? FileImage(_userImage!)
                                    : NetworkImage(
                                    "${fetchInfo.image}")
                                as ImageProvider, // Replace with your default avatar image.
                              )
                                  :
                              const CircleAvatar(
                                backgroundColor: Color(0xffFFFFC2),
                                radius: 60,),
                              const SizedBox(height: 10),
                              const Text(
                                'Upload Image',
                                style: TextStyle(
                                  //color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Username',
                    style: TextStyle(
                      //color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xffF8F8FF),
                    ),
                    child: TextField(
                      controller: _emailController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: email,
                        //prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  //password Text field
                  const Text(
                    'Phone no',
                    style: TextStyle(
                      //color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xffF8F8FF),
                    ),
                    child: TextFormField(
                      controller: _phoneNoController,
                      keyboardType: TextInputType.number,
                      //readOnly: changeFields,
                      //initialValue: _phoneNoController.text??'',
                      decoration: InputDecoration(
                        labelText: "phoneN0",
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              // _obscurePassword = !_obscurePassword;
                            });
                          },
                          child: TextButton(
                            onPressed: () {
                              // Add your forgot password logic here
                            },
                            child: const Text('Change', style: TextStyle(color: Colors.red),),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Date of birth',
                    style: TextStyle(
                      //color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xffF8F8FF),
                    ),
                    child: TextFormField(
                      controller: _dobController,
                      //readOnly: changeFields,
                      //initialValue: fetchInfo.dateOfBirth,
                      decoration: InputDecoration(
                        labelText: 'Date of Birth',
                        //prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              // _obscurePassword = !_obscurePassword;
                            });
                          },
                          child: TextButton(
                            onPressed: () {
                              // Add your forgot password logic here
                            },
                            child: const Text('Change', style: TextStyle(color: Colors.red),),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async{
                        // Add your login logic here
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),),);
                        final UpdateUser user = UpdateUser();
                        if(_emailController.text!=null && (_phoneNoController.text!=null || _dobController.text!=null))
                        {
                          if(phoneN0 != _phoneNoController.text || dOB != _dobController.text || _userImage!=null){
                            print(_dobController.text);
                            await user.updateUserInfo(APILink.defaultEmail,
                              _phoneNoController.text,
                              _dobController.text,
                              _userImage?.path.toString(),
                            );
                            Navigator.pop(context);
                          }
                          else {
                            FlutterToast.showToast('Please update the fields values.');
                          }
                        }
                        else {
                          FlutterToast.showToast('Please check all the fields.');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('Save Setting',),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavBar(
      //   currentIndex: _currentIndex,
      //   onTap: (int index) {
      //     setState(() {
      //       _currentIndex = index;
      //     });
      //   },
      // ),
    );
  }
}
