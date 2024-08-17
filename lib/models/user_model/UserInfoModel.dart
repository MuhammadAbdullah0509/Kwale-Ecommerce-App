/// email : "abc@123"
/// label_name : "abc"
/// contact_no : "0312"
/// profile_image : "/kwale/Content/Image/avatar_icon.png"
// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kwale/screens/widgets_screens/http_link.dart';
import 'package:kwale/screens/widgets_screens/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import '../../screens/widgets_screens/flutter_toast.dart';

class UserInfoModel {
  UserInfoModel({
      String? email, 
      String? labelName, 
      String? contactNo,
      String? dOB,
      String? profileImage,}){
    _email = email;
    _labelName = labelName;
    _contactNo = contactNo;
    _profileImage = profileImage;
    _dOB = dOB;

}

  UserInfoModel.fromJson(dynamic json) {
    _email = json['email'];
    _labelName = json['label_name'];
    _contactNo = json['contact_no'];
    _profileImage = json['profile_image'];
    _dOB = json['date_of_birth'];
  }
  String? _email;
  String? _labelName;
  String? _contactNo;
  String? _profileImage;
  String? _dOB;
UserInfoModel copyWith({  String? email,
  String? labelName,
  String? contactNo,
  String? profileImage,
  String? dOB,
}) => UserInfoModel(  email: email ?? _email,
  labelName: labelName ?? _labelName,
  contactNo: contactNo ?? _contactNo,
  profileImage: profileImage ?? _profileImage,
  dOB: dOB ?? _dOB,
);
  String? get email => _email;
  String? get labelName => _labelName;
  String? get contactNo => _contactNo;
  String? get profileImage => _profileImage;
  String? get dOB => _dOB;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['label_name'] = _labelName;
    map['contact_no'] = _contactNo;
    map['profile_image'] = _profileImage;
    map['date_of_birth'] = _dOB;
    return map;
  }

}

class fetchInfo {
  List<UserInfoModel> a = [];
  static var image;
  static var imagePost;
  static var name;
  static var userEmail;
  static var phoneNO;
  static String? dateOfBirth;
  String? date;
  SharedPref sP = SharedPref();

  Future<void> fetchUsers(email) async {
    try {
      var response = await http.post(
        Uri.parse('${APILink.link}UserInformation/GetUser'),
        body: ({"email": email.toString()}),
      );
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          var data = jsonDecode(response.body) as Map<String, dynamic>;
          a.add(UserInfoModel.fromJson(data));
          sP.addStringToSF('name', a[0].labelName.toString());
          image = APILink.imageLink + a[0].profileImage.toString();
          imagePost = a[0].profileImage.toString();
          print("pos${imagePost}");
          name = a[0].labelName;
          userEmail = a[0].email;
          phoneNO = a[0].contactNo;
          date = (a[0].dOB);
          DateTime dateFromAPI = DateTime.parse(date!);
          dateOfBirth = DateFormat('dd-MM-yyyy').format(dateFromAPI);
          // print(image);
          print("name${a[0].labelName}");
          print("daa${dateOfBirth}");
          return a.add(UserInfoModel.fromJson(data));
        }
      }
      else {
        print(response.statusCode);
      }
    }catch(exception){
      print(exception);
      throw exception;
    }
  }



  Future<void> addUser(email,name,phone/*,date,image*/) async
  {
    var response = await http.post(Uri.parse("${APILink.link}UserInformation/insertUser"),
        body: ({
          "email":email.toString(),
          "label_name":name.toString(),
          "contact_no":phone.toString(),
          //"date_of_birth":date.toString(),
        }));
    if(response.statusCode == 200)
    {
     // await addUserImage(email, image);
      FlutterToast.showToast('Your Address has been saved');
    }
    else if(response.statusCode == 500)
    {
      FlutterToast.showToast('something went wrong to the server please try again');
    }
  }

  Future<void> addUserImage(email,image) async
  {
    var url = Uri.parse("${APILink.link}UserInformation/Upload_Image?email=${email.toString()}");
    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('photo', image));
    var response = await request.send();
    if (response.statusCode == 200) {
      // Image uploaded successfully

      print('Image uploaded successfully');
    } else {
      // Handle the error
      print('Failed to upload image. Status code: ${response.statusCode}');
    }
  }

  //fetch vendor
  static var venImage;
  static var venImagePost;
  static var venName;
  static var venEmail;
  static var venPhoneNO;
  static String? venDateOfBirth;
  String? venDate;
  List<UserInfoModel> v = [];
  Future<void> fetchVendors(email) async {
    try {
      var response = await http.post(
        Uri.parse('${APILink.link}UserInformation/GetUser'),
        body: ({"email": email.toString()}),
      );
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          var data = jsonDecode(response.body) as Map<String, dynamic>;
          v.add(UserInfoModel.fromJson(data));
          sP.addStringToSF('name', v[0].labelName.toString());
          venImage = APILink.imageLink + v[0].profileImage.toString();
          venImagePost = v[0].profileImage.toString();
          print("pos${imagePost}");
          venName = v[0].labelName;
          venEmail = v[0].email;
          venPhoneNO = v[0].contactNo;
         // venDate = (v[0].dOB);
         // venDateOfBirth = DateFormat('dd-MM-yyyy').format(dateFromAPI);
          // print(image);
          print("name${v[0].labelName}");
          return v.add(UserInfoModel.fromJson(data));
        }
      }
      else {
        print(response.statusCode);
      }
    }catch(exception){
      print(exception);
      throw exception;
    }
  }

}