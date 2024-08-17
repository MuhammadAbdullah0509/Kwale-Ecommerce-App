import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../screens/widgets_screens/flutter_toast.dart';
import '../../screens/widgets_screens/http_link.dart';
class AuctionModel {
  AuctionModel({
    this.email,
    this.auctionId,
    this.name,
    this.image1,
    this.image2,
    this.image3,
    this.quantity,
    this.status,
    this.soledAmount,
    this.description
  });

  AuctionModel.fromJson(dynamic json) {
    email = json['email'];
    auctionId = json['auction_id'];
    name = json['name'];
    image1 = json['image1'];
    image2 = json['image2'];
    image3 = json['image3'];
    quantity = json['quantity'];
    status = json['status'];
    soledAmount = json['soled_amount'];
    description = json['description'];
  }
  String? email;
  int? auctionId;
  String? name;
  String? image1;
  String? image2;
  String? image3;
  int? quantity;
  bool? status;
  dynamic? soledAmount;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['auction_id'] = auctionId;
    map['name'] = name;
    map['image1'] = image1;
    map['image2'] = image2;
    map['image3'] = image3;
    map['quantity'] = quantity;
    map['status'] = status;
    map['soled_amount'] = soledAmount;
    map['description'] = description;
    return map;
  }

}

class Auctions{
  static List<AuctionModel> auctions = [];
  Future<void> getVendorAuctions(email) async
  {
    var response = await http.get(Uri.parse("${APILink.link}Vendor/GetVendorAuctions?email=${email.toString()}"),);
    if(response.statusCode == 200)
    {
      if(response.body.isNotEmpty){
      Iterable<dynamic> list = jsonDecode(response.body);
      auctions = list.map((e) => AuctionModel.fromJson(e)).toList();
      }
    }
    else {
      print(response.statusCode);
      FlutterToast.showToast("Something went wrong with the server");
    }
  }

  //get specific Auction Detail
  static List<AuctionModel> specificAuction =[];
  Future<void> specificAuctionDetail(id) async
  {
    var response = await http.get(Uri.parse("${APILink.link}Vendor/GetSpecificAuction?id=$id"),);
    if(response.statusCode == 200){
      if(response.body.isNotEmpty) {
        Iterable<dynamic> list = jsonDecode(response.body);
        specificAuction = list.map((e) => AuctionModel.fromJson(e)).toList();
      }
    }
    else{
      FlutterToast.showToast('There is something wrong with the server please try again');
    }
  }

  //Add New Auctions
  Future<void> addAuctions(email,name,des,image1,image2,image3) async
  {
    var response = await http.post(Uri.parse("${APILink.link}Vendor/AddAuctions"),
    body: ({
      "email": email.toString(),
      "name": name.toString(),
      "quantity": 1.toString(),
      "status": true.toString(),
      "soled_amount": 0.toString(),
      "description": des.toString()
    }));
    if(response.statusCode == 200)
    {
      print(response.body);
      await addAuctionImages(int.parse(response.body), email, image1, image2, image3);
      FlutterToast.showToast("Added successfully");
    }
    else{
      print(response.statusCode);
      FlutterToast.showToast("Something went wrong");
    }
  }

  Future<void> addAuctionImages(id,email,image1,image2,image3) async
  {
    var url = Uri.parse("${APILink.link}Vendor/AddAuctionsImages?id=$id&email=${email.toString()}");
    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('photo', image1,));
    request.files.add(await http.MultipartFile.fromPath('photo1', image2,));
    request.files.add(await http.MultipartFile.fromPath('photo2', image3,));
    var response = await request.send();
    if (response.statusCode == 200) {
      // Image uploaded successfully
      print('Image uploaded successfully');
    } else {
      // Handle the error
      print('Failed to upload image. Status code: ${response.statusCode}');
    }
  }

  Future<void> deleteAuctions(id) async
  {
    var response = await http.post(Uri.parse("${APILink.link}Vendor/DeleteAuction?id=$id"));
    if(response.statusCode == 200){
      FlutterToast.showToast("Successfully Deleted");
    }
    else if(response.statusCode == 500)
    {
      FlutterToast.showToast("Something went wrong");
    }
    else {
      print(response.statusCode);
    }
  }

  //All Auctions for user side
  Future<void> allAuctions() async
  {
    var response = await http.get(Uri.parse("${APILink.link}Auction/GetAuctions"),);
    if(response.statusCode == 200)
    {
      if(response.body.isNotEmpty) {
        Iterable<dynamic> list = jsonDecode(response.body);
        auctions = list.map((e) => AuctionModel.fromJson(e)).toList();
        print(list);
      }
    }
    else {
      print(response.statusCode);
      FlutterToast.showToast("Something went wrong with the server");
    }
  }
}