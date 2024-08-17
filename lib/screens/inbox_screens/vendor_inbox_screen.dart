// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kwale/models/chat_model/MessagesModel.dart';
import 'package:kwale/models/user_model/UserInfoModel.dart';
import 'package:kwale/models/vendorModels/GetSpecificVendor.dart';
import 'package:kwale/screens/inbox_screens/chat_lists.dart';
import 'package:kwale/screens/widgets_screens/http_link.dart';
import 'dart:io';

class ChatMessage{
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}

class VendorChatScreen extends StatefulWidget {
  String? name, image,email, message;
  bool? status;
  VendorChatScreen({super.key, this.name,this.image,this.email,this.status, this.message});

  @override
  VendorChatScreenState createState() => VendorChatScreenState();
}

class VendorChatScreenState extends State<VendorChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final GetAllMessages getAllMessages = GetAllMessages();
  final ScrollController _scrollController =  ScrollController();
  final fetchInfo _fetchuser = fetchInfo();

  load() async{
    await getAllMessages.getMessages(APILink.vendorEmail,widget.email);
    await _fetchuser.fetchUsers(widget.email);
    widget.message!=null
        ?
    await getAllMessages.addVendorMessage(
        GetVendor.specificVendor[0].email,
        widget.email,
        GetVendor.specificVendor[0].labelName.toString(),
        widget.name,
        widget.message.toString(),
        "vendor",
        _userImage?.path.toString()

    )
        :
    "";

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //widget.message!=null ?_messageController.text = widget.message.toString():"";
    load().whenComplete(() {
      Future.delayed(const Duration(milliseconds: 100), () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollToBottom();
        });
      });
      setState(() {
      });
    });
  }
  void scrollToBottom() async{
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }
  File? _userImage;
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _userImage = File(pickedImage.path);
        _messageController.text = _userImage!.path.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back,color: Colors.black,),
                ),
                const SizedBox(width: 2,),
                widget.image!=null?
                CircleAvatar(
                  backgroundImage: NetworkImage("${widget.image}"),
                  maxRadius: 20,
                )
                :
                const CircleAvatar(
                  maxRadius: 20,
                  child: Text('No Image'),
                ),
                const SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("${widget.name}",style: const TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: (){
                      _showCustomAlertDialog();
                    },
                    icon: const Icon(Icons.delete_rounded,color: Colors.red,),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child:  GetAllMessages.vendorMessageList.isNotEmpty ?
            StreamBuilder(
              stream: fetchMessage(const Duration(seconds: 1)),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.hasData){
                  return  ListView.builder(
                    itemCount: GetAllMessages.vendorMessageList.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: _scrollController,
                    itemBuilder: (context, index){
                      return  Container(
                        padding: const EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                        child: Align(
                          alignment: (GetAllMessages.vendorMessageList[index].content_type == "user"?Alignment.topLeft:Alignment.topRight),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: (GetAllMessages.vendorMessageList[index].content_type == "user"?Colors.grey.shade200:Colors.blue[200]),
                            ),
                            child: GetAllMessages.vendorMessageList[index].messageImage==null?
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: GetAllMessages.vendorMessageList[index].umessage.toString().contains("http")
                                  ?
                              GestureDetector(
                                onTap: (){
                                  _showfullPicture(GetAllMessages.vendorMessageList[index].umessage.toString());
                                },
                                child: SizedBox(
                                  width: 184,
                                  child: Image(image: NetworkImage('${GetAllMessages.vendorMessageList[index].umessage}'),),
                                ),
                              )
                                  :
                              Text(GetAllMessages.vendorMessageList[index].umessage!=null?
                              GetAllMessages.vendorMessageList[index].umessage.toString()
                                  :"",
                              ),
                            ):
                            GestureDetector(
                              onTap: (){
                                _showfullPicture(GetAllMessages.vendorMessageList[index].messageImage.toString());
                              },
                              child: SizedBox(
                                width: 184,
                                child: Image(image: NetworkImage('${APILink.imageLink}${GetAllMessages.vendorMessageList[index].messageImage}'),),
                              ),
                            ),
                            // child: Text(GetAllMessages.vendorMessageList[index].umessage!=null?
                            //   GetAllMessages.vendorMessageList[index].umessage.toString()
                            //     : ""
                            // //GetAllMessages.vendorMessageList[index].umessage.toString(), style: const TextStyle(fontSize: 15),
                            // ),
                          ),
                        ),
                      );
                    },
                  );
                }
                if(snapshot.hasError) return const Center(child: Text("unable to load data"));
                return const Center(child: Text("Loading..."));
            },):
            const Center(child: Text("No Message")),
          ),

          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 10,bottom: 10,top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () async{
                      await _pickImage();
                      _messageController.text = _userImage!.path.toString();
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(Icons.add, color: Colors.white, size: 20, ),
                    ),
                  ),
                  const SizedBox(width: 15,),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  const SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: () async{
                      await getAllMessages.addVendorMessage(
                        GetVendor.specificVendor[0].email,
                        widget.email,
                        GetVendor.specificVendor[0].labelName.toString(),
                        widget.name,
                        _messageController.text,
                        "vendor",
                        _userImage?.path.toString()

                      );
                      _messageController.clear();
                      _userImage = null;
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 200),
                      );
                    },
                    backgroundColor: Colors.blue,
                    elevation: 0,
                    child: const Icon(Icons.send,color: Colors.white,size: 18,),
                  ),
                ],

              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(String message) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void sendMessage() {
    String messageText = _messageController.text;
    if (messageText.isNotEmpty) {
      setState(() {
        //_messages.insert(0, messageText);
      });
      _messageController.clear();
    }
  }
  Stream fetchMessage(Duration refreshTime) async* {
    while (true) {
      await Future.delayed(refreshTime);
      yield  getAllMessages.getMessages(APILink.vendorEmail,widget.email);//GetVendor.specificVendor[0].email
    }
  }

  //alert box
  _showCustomAlertDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Alert"),
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              //color: const Color(0xffF8F8FF),
            ),
            child: const Text("Are you sure you want to delete this chat?"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async{
                // Do something with the text from the text field
                await getAllMessages.removeVendorMessage(fetchInfo.venEmail,widget.email);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatList()));
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }
  _showfullPicture(image) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(""),
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              //color: const Color(0xffF8F8FF),
            ),
            child: Image(image:
            image.toString().contains("http")
                ?
            NetworkImage(image.toString())
                :
            NetworkImage("${APILink.imageLink}${image.toString()}"),),
          ),
        );
      },
    );
  }
}

