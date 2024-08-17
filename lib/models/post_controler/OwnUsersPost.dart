import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../screens/widgets_screens/flutter_toast.dart';
import '../../screens/widgets_screens/http_link.dart';

import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'dart:convert';

class OwnUsersPost {
  OwnUsersPost({
    this.postId,
    this.email,
    this.category,
    this.itemName,
    this.description,
    this.postDate,
    this.itemImage,
  });

  OwnUsersPost.fromJson(dynamic json) {
    postId = json['post_Id'];
    email = json['email'];
    category = json['category'];
    itemName = json['itemName'];
    description = json['description'];
    postDate = json['post_date'];
    itemImage = json['item_image'];
    amount = json['amount'];
  }
  int? postId;
  String? email;
  String? category;
  String? itemName;
  String? description;
  String? postDate;
  String? itemImage;
  dynamic? amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['post_Id'] = postId;
    map['email'] = email;
    map['category'] = category;
    map['itemName'] = itemName;
    map['description'] = description;
    map['post_date'] = postDate;
    map['item_image'] = itemImage;
    map['amount'] = amount;
    return map;
  }

}

class GetOwnUserPost{
  static List<OwnUsersPost> userPosts = [];
  Future<void> getOwnPost(email) async
  {
    var response = await http.get(Uri.parse("${APILink.link}Posts/GetUsersPost?email=${email.toString()}"));
    if(response.statusCode == 200){
      if(response.body.isNotEmpty) {
        Iterable<dynamic> list = jsonDecode(response.body);
        print(response.body);
        userPosts = list.map((e) => OwnUsersPost.fromJson(e)).toList();
      }
    }
  }

  Future<void> addUsersPost(email,name,category,description,amount,image,date) async
  {
    var response = await http.post(Uri.parse("${APILink.link}Posts/AddPost"),
        body: ({
          "email":email.toString(),
          "itemName":name.toString(),
          "category":category.toString(),
          "description":description.toString(),
          "amount":amount.toString(),
          //"item_image":image.toString(),
          "post_date": DateTime.now().toString(),
        }));
    if(response.statusCode == 200)
    {
      await addUsersPostImage(email,name,image);
      FlutterToast.showToast('Your post has been posted');
    }
    else if(response.statusCode == 500)
    {
      FlutterToast.showToast('something went wrong to the server please try again');
    }
  }

  Future<void> addUsersPostImage(email,name,image) async
  {
    var url = Uri.parse("${APILink.link}Posts/AddPostImage?email=${email.toString()}&name=${name.toString()}");
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

  Future<void> deletePost(id) async
  {
    var response = await http.post(Uri.parse("${APILink.link}Posts/DeletePost?id=${id}"));
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

  static List<OwnUsersPost> posts = [];
  Future<void> allPost() async
  {
    var response = await http.get(Uri.parse("${APILink.link}Posts/GetAllPosts"));
    if(response.statusCode == 200){
      if(response.body.isNotEmpty) {
        Iterable<dynamic> list = jsonDecode(response.body);
        posts = list.map((e) => OwnUsersPost.fromJson(e)).toList();
      }
    }
  }
}
