import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../screens/widgets_screens/flutter_toast.dart';
import '../../screens/widgets_screens/http_link.dart';
class UserAddress {
  UserAddress({
      this.addressId, 
      this.email, 
      this.phoneNo, 
      this.city, 
      this.street,});

  UserAddress.fromJson(dynamic json) {
    addressId = json['address_id'];
    email = json['email'];
    phoneNo = json['phone_no'];
    city = json['city'];
    street = json['street'];
  }
  int? addressId;
  String? email;
  String? phoneNo;
  String? city;
  String? street;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address_id'] = addressId;
    map['email'] = email;
    map['phone_no'] = phoneNo;
    map['city'] = city;
    map['street'] = street;
    return map;
  }
}

class GetUserAddress{
  static List<UserAddress> userAddress = [];
  Future<void> getAddress(email) async
  {
    var response = await http.get(Uri.parse("${APILink.link}Address/GetUserAddress?email=${email.toString()}"));
    if(response.statusCode == 200){
      if(response.body.isNotEmpty) {
        Iterable<dynamic> list = jsonDecode(response.body);
        userAddress = list.map((e) => UserAddress.fromJson(e)).toList();
      }
    }
    else if(response.statusCode == 500)
    {
      FlutterToast.showToast("Something went wrong");
    }
    else {
      print("stat${response.statusCode}");
    }
  }

  Future<void> addAddress(email,phone,city,street) async
  {
    var response = await http.post(Uri.parse("${APILink.link}Address/AddAddress"),
        body: ({
          "email":email.toString(),
          "phone_no":phone.toString(),
          "city":city.toString(),
          "street":street.toString(),
        }));
    if(response.statusCode == 200)
    {
      FlutterToast.showToast('Your Address has been saved');
    }
    else if(response.statusCode == 500)
    {
      FlutterToast.showToast('something went wrong to the server please try again');
    }
  }
}