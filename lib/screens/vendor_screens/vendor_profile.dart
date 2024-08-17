// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kwale/models/vendorModels/GetSpecificVendor.dart';
import 'package:kwale/screens/home_screen/home_screen.dart';
import 'package:kwale/screens/login_screen/login_screen.dart';
import 'package:kwale/screens/profile_screen/profile_setting_screen.dart';
import 'package:kwale/screens/vendor_screens/vendor_bottom_nav_bar.dart';
import 'package:kwale/screens/vendor_screens/vendor_sales_history.dart';
import 'package:kwale/screens/vendor_screens/vendor_setting.dart';
import 'package:kwale/screens/widgets_screens/http_link.dart';
import 'package:kwale/screens/widgets_screens/shared_pref.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../models/user_model/UserInfoModel.dart';

class VendorProfile extends StatefulWidget {
  const VendorProfile({super.key});

  @override
  _VendorProfileState createState() => _VendorProfileState();
}

class _VendorProfileState extends State<VendorProfile> {
  SharedPref sP = SharedPref();
  //final GetVendor getVendor = GetVendor();
  final fetchInfo _fetchInfo = fetchInfo();
  int _currentIndex = 0;
  File? _userImage;
  var name = '' ;
  var image;
  DateTime? dateTime;

  load() async{
    //await getVendor.getSpecificVendor(GetVendor.specificVendor[0].email);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    image = fetchInfo.image;
    load().whenComplete(() {
      setState(() {
      });
    });
  }


  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _userImage = File(pickedImage.path);
      });
    }
  }

  Future<void> _launchEmail() async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'kwale@gmail.com', // Replace with your support email address
      queryParameters: {'subject': 'Support Request'},
    );

    if (await canLaunch(_emailLaunchUri.toString())) {
      await launch(_emailLaunchUri.toString());
    } else {
      throw 'Could not launch email';
    }
  }

  void _openSettings() {
    // Implement your settings screen or navigate to it using Navigator.
  }

  void _openPrivacyPolicy() async {
    const url =
        'https://www.example.com/privacy_policy'; // Replace with your privacy policy URL.
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
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
          'My Account',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  //onTap: _pickImage,
                  child: image!=null?  CircleAvatar(
                    backgroundColor: const Color(0xffFFFFC2),
                    radius: 60,
                    backgroundImage:
                    NetworkImage("${fetchInfo.image}"),
                  ):const CircleAvatar(
                      backgroundColor: Color(0xffFFFFC2),
                      radius: 60,
                      child: Image(image: AssetImage('assets/images/profile/avatar_icon.png'))),
                ),
                const SizedBox(width: 16),
                Text(fetchInfo.name.toString(),
                    style: const TextStyle(
                      fontSize: 24,
                    )),
              ],
            ),
            const SizedBox(height: 16),
            Align(alignment: Alignment.centerRight,
              child: ToggleSwitch(
                minWidth: 90.0,
                initialLabelIndex: 1,
                cornerRadius: 20.0,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                totalSwitches: 2,
                labels: const ['User', 'Vendor'],
                icons: const [Icons.person, Icons.account_box],
                activeBgColors: const [[Colors.green],[Colors.red]],
                onToggle: (index) {
                  if(index == 0){
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return HomeScreen();
                        }), (r) {
                          return false;
                        });
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            //setting
            GestureDetector(
              onTap: () {
                //_openSettings;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileSettingScreen(),
                  ),
                ).then((_) {
                  setState(() {
                    image = fetchInfo.image;
                  });
                });
              },
              child: buildContainer(
                  const Icon(Icons.settings_outlined), 'Settings'),
            ),
            const SizedBox(height: 16),
            //sales history
            GestureDetector(
              onTap: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VendorSalesHistory(),
                  ),
                ).then((_) {
                  setState(() {});
                });
              },
              child: buildContainer(
                  const Icon(Icons.history), 'Sales History'),
            ),
            //privacy policy
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                //_openPrivacyPolicy();
              },
              child: buildContainer(
                  const Icon(Icons.verified_user_outlined),
                  'Privacy Policy'),
            ),
            //About us
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {},
              child: buildContainer(
                  const Icon(Icons.error_outline), 'About Us'),
            ),
            //Help and Contact us
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                _launchEmail();
              },
              child: buildContainer(const Icon(Icons.message_outlined),
                  'Help & Contact Us'),
            ),
            //Logout
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return const LoginScreen();
                    }), (r) {
                      return false;
                    });
              },
              child: buildContainer(
                  const Icon(Icons.logout_sharp), 'Logout'),
            ),
            const Spacer(),
            const Center(
                child: Text(
                  '@Kwale',
                  style: TextStyle(color: Colors.black),
                )),
          ],
        ),
      ),
      bottomNavigationBar: VendorNevBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
  Widget buildContainer(Icon icon, String text) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 0.1)),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center ,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: icon,
            ),
          ),
          //const SizedBox(height: 10,),
          Text(
            text,
            style: const TextStyle(color: Colors.black),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              onTap: () {
                //Move To New Window
              },
              child: const Icon(Icons.arrow_forward_ios_outlined),
            ),
          ),
        ],
      ),
    );
  }

}
