import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../screens/widgets_screens/flutter_toast.dart';
import '../../screens/widgets_screens/http_link.dart';
class GetSpecificVendor {
  GetSpecificVendor({
    this.email,
    this.labelName,
    this.contactNo,
    this.profileImage,
    this.date,
  });

  GetSpecificVendor.fromJson(dynamic json) {
    email = json['email'];
    labelName = json['label_name'];
    contactNo = json['contact_no'];
    profileImage = json['profile_image'];
    date = json['date_of_birth'];
  }
  String? email;
  String? labelName;
  String? contactNo;
  String? profileImage;
  String? date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['label_name'] = labelName;
    map['contact_no'] = contactNo;
    map['profile_image'] = profileImage;
    map['date_of_birth'] = date;
    return map;
  }
}

class GetVendor{
  static List<GetSpecificVendor> specificVendor= [];
  static var venImage;
  Future<void> getSpecificVendor(email) async
  {
    var response = await http.get(Uri.parse("${APILink.link}Vendor/GetVendorInfo?email=${email.toString()}"),);
    if(response.statusCode == 200)
    {
      if(response.body.isNotEmpty){
      Iterable<dynamic> list = jsonDecode(response.body);
      //specificVendor.add(GetSpecificVendor.fromJson(list));
      specificVendor = list.map((e) => GetSpecificVendor.fromJson(e)).toList();
      venImage = "${APILink.imageLink}${specificVendor[0].profileImage.toString()}";
      print("VenImage${venImage}");
      print("list${list}");
      }
    }
    else {
      print(email);
      print(response.statusCode);
    }
  }

  Future<void> addVendor(email,name,phone/*,date,image*/) async
  {
    var response = await http.post(Uri.parse("${APILink.link}Vendor/VendorInfo"),
        body: ({
          "email":email.toString(),
          "label_name":name.toString(),
          "contact_no":phone.toString(),
          //"date_of_birth":date.toString(),
          //"profile_image":image.toString()
        }));
    if(response.statusCode == 200)
    {
      //await addVendorImage(email, image);
      FlutterToast.showToast('Your Address has been saved');
    }
    else if(response.statusCode == 500)
    {
      FlutterToast.showToast('something went wrong to the server please try again');
    }
  }

  Future<void> updateVendorInfo(email,phoneno,dob,image) async
  {
    var response = await http.post(Uri.parse("${APILink.link}Vendor/UpdateVendorInfo"),
      body: ({
        "email": email,
        "contact_no": phoneno,
        "date_of_birth":dob,
      }),
    );
    if(response.statusCode == 200)
    {
      if(image!= null){
        await addVendorImage(email,image);
      }
      FlutterToast.showToast('Your Information has been updated Successfully');
    }
    else {
      FlutterToast.showToast('Something went wrong please try again');
    }
  }

  Future<void> addVendorImage(email,image) async
  {
    var url = Uri.parse("${APILink.link}Vendor/UploadVendorImage?email=${email.toString()}");
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