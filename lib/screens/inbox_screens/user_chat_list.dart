import 'package:flutter/material.dart';
import 'package:kwale/screens/inbox_screens/user_chat_widget.dart';
import 'package:kwale/screens/widgets_screens/http_link.dart';
import '../../models/chat_model/ChatModel.dart';
import '../widgets_screens/bottom_nav_bar.dart';
import 'chat_widgets.dart';

class ChatUsers{
  String? name;
  String? messageText;
  String? image;
  String? time;
  ChatUsers({required this.name,required this.messageText, this.image,required this.time});}

class UserChatList extends StatefulWidget {
  const UserChatList({super.key});

  @override
  State<UserChatList> createState() => _UserChatListState();
}

class _UserChatListState extends State<UserChatList> {
  int _currentIndex = 0;
  final GetChatList chatList = GetChatList();
  load() async{
    await chatList.getUserChatList(APILink.defaultEmail);
    setState(() {});
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load().whenComplete(() {
      setState(() {});});
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
            GetChatList.userChatList.isNotEmpty?
            ListView.builder(
              itemCount: GetChatList.userChatList.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 16),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: UserConversationList(
                    name: GetChatList.userChatList[index].vName,
                    vemail: GetChatList.userChatList[index].vEmail,
                    status: GetChatList.userChatList[index].vStatus,
                    image: GetChatList.userChatList[index].vImage,
                    time: GetChatList.userChatList[index].chatDate,
                    uemail: GetChatList.userChatList[index].uEmail,
                    isMessageRead: (index == 0 || index == 3)?true:false,
                  ),
                );
              },
            )
                :
            Center(child: Padding(
              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/2.5),
              child: const Text("No Chat"),
            ),),


          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
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


