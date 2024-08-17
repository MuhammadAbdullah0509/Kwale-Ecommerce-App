import 'package:flutter/material.dart';
import 'package:kwale/screens/widgets_screens/http_link.dart';

import '../../models/chat_model/ChatModel.dart';
import '../vendor_screens/vendor_bottom_nav_bar.dart';
import 'chat_widgets.dart';

class ChatUsers{
  String? name;
  String? messageText;
  String? image;
  String? time;
  ChatUsers({required this.name,required this.messageText, this.image,required this.time});}

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  int _currentIndex = 0;
  final GetChatList chatList = GetChatList();
  List<ChatUsers> chatUsers = [
    ChatUsers(name: "Jane Russel",   messageText: "Awesome Setup",      image: "assets/images/profile/avatar_icon.png", time: "Now"),
    ChatUsers(name: "Glady's Murphy",messageText: "That's Great",       image: "assets/images/profile/avatar_icon.png", time: "Yesterday"),
    ChatUsers(name: "Jorge Henry",   messageText: "Hey where are you?", image: "assets/images/profile/avatar_icon.png", time: "31 Mar"),
    ChatUsers(name: "Philip Fox",    messageText: "Busy! Call me in 20 mins", image: "assets/images/profile/avatar_icon.png", time: "28 Mar"),
    ChatUsers(name: "Debra Hawkins", messageText: "Thankyou, It's awesome", image: "assets/images/profile/avatar_icon.png", time: "23 Mar"),
    ChatUsers(name: "Jacob Pena",    messageText: "will update you in evening", image: "assets/images/profile/avatar_icon.png", time: "17 Mar"),
    ChatUsers(name: "Andrey Jones",  messageText: "Can you please share the file?", image: "assets/images/profile/avatar_icon.png", time: "24 Feb"),
    ChatUsers(name: "John Wick",     messageText: "How are you?", image: "assets/images/profile/avatar_icon.png", time: "18 Feb"),
  ];
  void load() async{
    await chatList.getVendorChatList(APILink.vendorEmail);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16,right: 16,top: 40),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        }, icon: const Icon(Icons.arrow_back_ios_new)),
                    const SizedBox(width: 2,),
                    const Text("Conversations",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
                    // Container(
                    //   padding: const EdgeInsets.only(left: 8,right: 8,top: 2,bottom: 2),
                    //   height: 30,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(30),
                    //     color: Colors.pink[50],
                    //   ),
                    //   child: const Row(
                    //     children: <Widget>[
                    //       Icon(Icons.add,color: Colors.pink,size: 20,),
                    //       SizedBox(width: 2,),
                    //       Text("Add New",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Colors.grey.shade100
                      )
                  ),
                ),
              ),
            ),
            ListView.builder(
              itemCount: GetChatList.chatList.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 16),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConversationList(
                    name: GetChatList.chatList[index].uName,
                    uemail: GetChatList.chatList[index].uEmail,
                    status: GetChatList.chatList[index].uStatus,
                    image: GetChatList.chatList[index].uImage,
                    time: GetChatList.chatList[index].chatDate,
                    isMessageRead: (index == 0 || index == 3)?true:false,
                  ),
                );
              },
            ),


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
}


