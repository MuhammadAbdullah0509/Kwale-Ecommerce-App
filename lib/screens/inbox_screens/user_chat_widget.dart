import 'package:flutter/material.dart';
import 'package:kwale/screens/inbox_screens/user_message.dart';
import 'package:kwale/screens/inbox_screens/vendor_inbox_screen.dart';
import 'package:kwale/screens/widgets_screens/http_link.dart';
import 'package:intl/intl.dart';

class UserConversationList extends StatefulWidget{
  String? name;
  String? uemail,vemail;
  bool? status;
  String? image;
  String? time;
  bool isMessageRead;
  UserConversationList({super.key, required this.name,required this.uemail,required this.status,this.vemail,
    this.image,required this.time,required this.isMessageRead});
  @override
  UserConversationListState createState() => UserConversationListState();
}

class UserConversationListState extends State<UserConversationList> {
  // DateTime dateFromAPI = DateTime.parse(widget.time!);
  // String? date= DateFormat('dd-MM-yyyy').format(dateFromAPI);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => UserChatMessage(
          name: widget.name,
          image: "${APILink.imageLink}${widget.image}",
          email: widget.vemail,
          status: widget.status,

        )));
      },
      child: Container(
        padding: const EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xffF8F8FF),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage("${APILink.imageLink}${widget.image.toString()}"),
                    maxRadius: 30,
                  ),
                  const SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.name.toString(), style: const TextStyle(fontSize: 16),),
                          //const SizedBox(height: 6,),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}