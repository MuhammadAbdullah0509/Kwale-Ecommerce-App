/// email : "abc@123"
/// label_name : "Spider"
/// contact_no : "031245112"
/// profile_image : "/kwale/Content/Image/avatar_icon.png"
/// date_of_birth : "2022-02-02T00:00:00"
import 'package:http/http.dart' as http;
import 'package:kwale/models/user_model/UserInfoModel.dart';
import 'package:kwale/screens/login_screen/login_screen.dart';
import 'package:kwale/screens/widgets_screens/http_link.dart';

import '../../screens/widgets_screens/flutter_toast.dart';
import 'package:flutter/material.dart';

import '../vendorModels/GetSpecificVendor.dart';

class UpdateUserModel {
  UpdateUserModel({
      String? email, 
      String? labelName, 
      String? contactNo, 
      String? profileImage, 
      String? dateOfBirth,}){
    _email = email;
    _labelName = labelName;
    _contactNo = contactNo;
    _profileImage = profileImage;
    _dateOfBirth = dateOfBirth;
}

  UpdateUserModel.fromJson(dynamic json) {
    _email = json['email'];
    _labelName = json['label_name'];
    _contactNo = json['contact_no'];
    _profileImage = json['profile_image'];
    _dateOfBirth = json['date_of_birth'];
  }
  String? _email;
  String? _labelName;
  String? _contactNo;
  String? _profileImage;
  String? _dateOfBirth;
UpdateUserModel copyWith({  String? email,
  String? labelName,
  String? contactNo,
  String? profileImage,
  String? dateOfBirth,
}) => UpdateUserModel(  email: email ?? _email,
  labelName: labelName ?? _labelName,
  contactNo: contactNo ?? _contactNo,
  profileImage: profileImage ?? _profileImage,
  dateOfBirth: dateOfBirth ?? _dateOfBirth,
);
  String? get email => _email;
  String? get labelName => _labelName;
  String? get contactNo => _contactNo;
  String? get profileImage => _profileImage;
  String? get dateOfBirth => _dateOfBirth;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['label_name'] = _labelName;
    map['contact_no'] = _contactNo;
    map['profile_image'] = _profileImage;
    map['date_of_birth'] = _dateOfBirth;
    return map;
  }

}

class UpdateUser{
  final fetchInfo _fetchInfo = fetchInfo();
  GetVendor vendor = GetVendor();
  Future<void> updateUserInfo(email,phoneno,dob,image) async
  {
    var response = await http.post(Uri.parse("${APILink.link}UserInformation/UpdateUser"),
    body: ({
      "email": email,
      "contact_no": phoneno,
      "date_of_birth":dob,
    }),
    );
    if(response.statusCode == 200)
    {
      image!=null?await addUserImage(email,image):null;
      FlutterToast.showToast('Your Information has updated Successfully');
      vendor.updateVendorInfo(email, phoneno, dob, image);
      await _fetchInfo.fetchUsers(email);
    }
    else {
      FlutterToast.showToast('Something went wrong please try again');
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

}
