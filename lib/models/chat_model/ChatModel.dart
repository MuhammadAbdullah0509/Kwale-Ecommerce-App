import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:kwale/screens/widgets_screens/flutter_toast.dart';

import '../../screens/widgets_screens/http_link.dart';

class ChatModel {
  ChatModel({
    this.conversionId,
    this.vEmail,
    this.vName,
    this.uEmail,
    this.uName,
    this.vImage,
    this.uImage,
    this.vStatus,
    this.uStatus,
    this.chatDate,
  });

  ChatModel.fromJson(dynamic json) {
    conversionId = json['conversion_id'];
    vEmail = json['v_email'];
    vName = json['v_name'];
    uEmail = json['u_email'];
    uName = json['u_name'];
    vImage = json['v_image'];
    uImage = json['u_image'];
    vStatus = json['v_status'];
    uStatus = json['u_status'];
    chatDate = json['chat_date'];
  }
  int? conversionId;
  String? vName;
  String? uEmail;
  String? uName;
  String? vImage;
  String? vEmail;
  String? uImage;
  bool? vStatus;
  bool? uStatus;
  String? chatDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['conversion_id'] = conversionId;
    map['v_email'] = vEmail;
    map['v_name'] = vName;
    map['u_email'] = uEmail;
    map['u_name'] = uName;
    map['v_image'] = vImage;
    map['u_image'] = uImage;
    map['v_status'] = vStatus;
    map['u_status'] = uStatus;
    map['chat_date'] = chatDate;
    return map;
  }
}

class GetChatList {
  static List<ChatModel> chatList = [];
  Future<void> getVendorChatList(email) async {
    var response = await http.get(
      Uri.parse(
          "${APILink.link}Chat/getChatList?email=${email.toString()}"),
    );
    if (response.statusCode == 200) {
      if(response.body.isNotEmpty){
      Iterable<dynamic> list = jsonDecode(response.body);
      chatList = list.map((e) => ChatModel.fromJson(e)).toList();
      }
    } else {
      FlutterToast.showToast("unable to load chat due to server error");
    }
  }

  Future<void> addConversationList(
      vEmail, vName, uEmail, uName, vimage, uimage) async {
    var response = await http.post(Uri.parse("${APILink.link}Chat/AddChat"),
        body: ({
          "v_email": vEmail.toString(),
          "v_name": vName.toString(),
          "u_email": uEmail.toString(),
          "u_name": uName.toString(),
          "v_image": vimage.toString(),
          "u_image": uimage.toString(),
          "v_status": true.toString(),
          "u_status": true.toString(),
          "chat_date": DateTime.now().toString(),
        }));
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.body);
      }
      //FlutterToast.showToast("message sent");
    } else {
      FlutterToast.showToast("there is something wrong with server");
    }
  }

  //user
  static List<ChatModel> userChatList = [];
  Future<void> getUserChatList(email) async {
    var response = await http.get(
      Uri.parse(
          "${APILink.link}Chat/getUserChatList?email=${email.toString()}"),
    );
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        Iterable<dynamic> list = jsonDecode(response.body);
        userChatList = list.map((e) => ChatModel.fromJson(e)).toList();
        print(list);
      }
    } else {
      FlutterToast.showToast("unable to load chat due to server error");
    }
  }
}
