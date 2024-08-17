// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kwale/models/chat_model/ChatModel.dart';
import 'package:kwale/models/chat_model/MessagesModel.dart';
import 'package:kwale/models/post_controler/OwnUsersPost.dart';
import 'package:kwale/models/user_model/UserInfoModel.dart';
import 'package:kwale/models/vendorModels/GetSpecificVendor.dart';
import 'package:kwale/screens/vendor_screens/vendor_bottom_nav_bar.dart';
import 'package:kwale/screens/widgets_screens/http_link.dart';

import '../inbox_screens/vendor_inbox_screen.dart';

class AllPost extends StatefulWidget {
  const AllPost({super.key});

  @override
  _AllPostState createState() => _AllPostState();
}

class _AllPostState extends State<AllPost> {
  int _currentIndex = 0;
  final TextEditingController _itemName = TextEditingController();
  final TextEditingController _itemDescription = TextEditingController();
  GetOwnUserPost oP = GetOwnUserPost();
  final GetChatList chatList = GetChatList();
  final fetchInfo user = fetchInfo();
  void load() async
  {
    await oP.allPost();
    setState(() {
    });
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            // Perform search action
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Post',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: GetOwnUserPost.posts!=null?
      ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: GetOwnUserPost.posts.length,
        itemBuilder: (BuildContext context, int index)
        {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    //height: 500,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black,width: 0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Add your post content here
                          Row(
                            children: [
                              Text(
                                GetOwnUserPost.posts[index].category.toString(),
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                             // const Spacer(),

                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            GetOwnUserPost.posts[index].itemName.toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            GetOwnUserPost.posts[index].description.toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                          // Text(
                          //   "Budget: ${
                          //   GetOwnUserPost.userPosts[index].amount.toString()}",
                          //   style: const TextStyle(fontSize: 16),
                          // ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: GetOwnUserPost.posts[index].itemImage.toString()!=null? 300:10,
                            child: Container(
                              decoration: const BoxDecoration(),
                              child: GetOwnUserPost.posts[index].itemImage.toString()!=null?
                              Image.network('${APILink.imageLink}${GetOwnUserPost.posts[index].itemImage.toString()}',
                                fit: BoxFit.fill,
                              )
                                  :
                              const Center(child: Text("No Image")),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () async{
                                await user.fetchUsers(GetOwnUserPost.posts[index].email);
                                print(fetchInfo.imagePost.toString());
                                print(fetchInfo.userEmail);
                                await chatList.addConversationList(
                                  //GetVendor.specificVendor[0].email,
                                  fetchInfo.venEmail,
                                  //GetVendor.specificVendor[0].labelName,
                                  fetchInfo.venName,
                                  fetchInfo.userEmail,
                                  fetchInfo.name,
                                  //GetVendor.specificVendor[0].profileImage,
                                  fetchInfo.venImagePost,
                                  fetchInfo.imagePost.toString(),
                                );
                                Navigator.push(context, MaterialPageRoute(builder: (context) => VendorChatScreen(
                                  name: fetchInfo.name,
                                  email: fetchInfo.userEmail,
                                  image: "${APILink.imageLink}${fetchInfo.imagePost}",
                                  message: "${APILink.imageLink}${GetOwnUserPost.posts[index].itemImage.toString()}",
                                )));
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                backgroundColor: Colors.red,
                              ),
                              child: const Text('Message',),
                            ),
                          ),
                          const SizedBox(height: 5),
                          // Add more content as needed
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ):
      const Center(child: Text('No Posts'),),
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
