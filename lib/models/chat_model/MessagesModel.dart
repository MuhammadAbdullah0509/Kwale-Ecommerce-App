// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../screens/widgets_screens/flutter_toast.dart';
import '../../screens/widgets_screens/http_link.dart';
class MessagesModel {
  MessagesModel({
    this.messageId,
    this.vemail,
    this.uemail,
    //this.vMessage,
    this.umessage,
    //this.vimage,
    //this.uimage,
    this.vname,
    this.uname,
    this.content_type,
    this.messageImage,
  });

  MessagesModel.fromJson(dynamic json) {
    messageId = json['message_id'];
    vemail = json['vemail'];
    uemail = json['uemail'];
    //vMessage = json['v_message'];
    umessage = json['umessage'];
    //vimage = json['vimage'];
    //uimage = json['uimage'];
    vname = json['vname'];
    uname = json['uname'];
    content_type = json['content_type'];
    messageImage = json['message_image'];
  }
  int? messageId;
  String? vemail;
  String? uemail;
  //String? vMessage;
  String? umessage;
  //dynamic? vimage;
  //dynamic? uimage;
  String? vname;
  String? uname;
  String? content_type;
  String? messageImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message_id'] = messageId;
    map['vemail'] = vemail;
    map['uemail'] = uemail;
    //map['v_message'] = vMessage;
    map['umessage'] = umessage;
    //map['vimage'] = vimage;
    //map['uimage'] = uimage;
    map['vname'] = vname;
    map['uname'] = uname;
    map['content_type'] = content_type;
    map['message_image'] = messageImage;
    return map;
  }

}

class GetAllMessages{
  static List<MessagesModel> vendorMessageList = [];
  Future<void> getMessages(vEmail,uEmail) async{
    var response = await http.get(Uri.parse
      ("${APILink.link}Chat/getMessages?vemail=${vEmail.toString()}&uemail=${uEmail.toString()}"),);
    if(response.statusCode == 200)
    {
      if(response.body.isNotEmpty) {
        Iterable<dynamic> list = jsonDecode(response.body);
        vendorMessageList = list.map((e) => MessagesModel.fromJson(e)).toList();
        print(list);
      }
    }
    else {
      FlutterToast.showToast("unable to load chat due to server error");
    }
  }

  Future<void> addVendorMessage(vEmail,uEmail,vName,uName,umessage,type,messageImage) async {
    if(messageImage!=null){
      print("not null${messageImage}");
      addMessageImage(uEmail, vEmail, messageImage,type);
    }
    else {
      var response = await http.post(Uri.parse("${APILink.link}Chat/AddMessage"),
    body: ({
      "vemail": vEmail.toString(),
      "uemail": uEmail.toString(),
      "umessage": messageImage==null?umessage.toString():"",
      "vname": vName.toString(),
      "uname":uName.toString(),
      "content_type": type.toString(),
      //"messageImage":messageImage.toString()
    }));
    if(response.statusCode == 200)
    {
      print(response.body);
      var res = await jsonDecode(response.body);
      addMessageImage(uEmail, vEmail, messageImage,res);
      FlutterToast.showToast("message sent");
    }
    else{
      FlutterToast.showToast("there is something wrong with server");
    }
    }
  }

  Future<void> addMessageImage(uemail,vemail,image,m_id) async
  {
    var url = Uri.parse("${APILink.link}Chat/Message_Image?uemail=${uemail.toString()}&vemail=${vemail.toString()}&"
        "messageid=${m_id.toString()}");
    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('photo', image,));
    var response = await request.send();
    if (response.statusCode == 200) {
      // Image uploaded successfully

      print('Image uploaded successfully${response.statusCode}');
    } else {
      // Handle the error
      print('Failed to upload image. Status code: ${response.statusCode}');
    }
  }

  Future<void> removeVendorMessage(vEmail,uEmail) async {
    var response = await http.post(Uri.parse("${APILink.link}Chat/DeleteMessage"
        "?vemail=${vEmail.toString()}&uemail=${uEmail.toString()}"),);
    if(response.statusCode == 200)
    {
      FlutterToast.showToast("chat delete");
    }
    else{
      FlutterToast.showToast("there is something wrong with server");
    }
  }

}