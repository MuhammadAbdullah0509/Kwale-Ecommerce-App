import 'package:flutter/material.dart';
import 'package:kwale/screens/inbox_screens/vendor_inbox_screen.dart';
import 'package:kwale/screens/widgets_screens/http_link.dart';
import 'package:intl/intl.dart';

class ConversationList extends StatefulWidget{
  String? name;
  String? uemail,vemail;
  bool? status;
  String? image;
  String? time;
  bool isMessageRead;
  ConversationList({super.key, required this.name,required this.uemail,required this.status,this.vemail,
    this.image,required this.time,required this.isMessageRead});
  @override
  ConversationListState createState() => ConversationListState();
}

class ConversationListState extends State<ConversationList> {
  // DateTime dateFromAPI = DateTime.parse(widget.time!);
  // String? date= DateFormat('dd-MM-yyyy').format(dateFromAPI);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => VendorChatScreen(
          name: widget.name,
          image: "${APILink.imageLink}${widget.image}",
          email: widget.uemail,
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
            // Text(widget.status ==true?
            // "Online"
            //     :
            // "offline"
            //   ,style: TextStyle(fontSize: 13,color: Colors.grey.shade600, fontWeight: widget.isMessageRead?FontWeight.bold:FontWeight.normal),
            // ),
            //Text(widget.time.toString(),style: TextStyle(fontSize: 12,fontWeight: widget.isMessageRead?FontWeight.bold:FontWeight.normal),),
          ],
        ),
      ),
    );
  }
}