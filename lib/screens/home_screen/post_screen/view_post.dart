import 'package:flutter/material.dart';
import 'package:kwale/models/post_controler/OwnUsersPost.dart';
import 'package:kwale/screens/home_screen/post_screen/post_screen.dart';
import 'package:kwale/screens/widgets_screens/http_link.dart';

import '../../widgets_screens/bottom_nav_bar.dart';

class ViewPost extends StatefulWidget {
  const ViewPost({super.key});

  @override
  _ViewPostState createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  final TextEditingController _itemName = TextEditingController();
  final TextEditingController _itemDescription = TextEditingController();
  String? selectedCategory;
  String? itemName;
  String? itemDescription;
  int _currentIndex = 0;
  GetOwnUserPost oP = GetOwnUserPost();
  void load() async {
    await oP.getOwnPost(APILink.defaultEmail);
    setState(() {});
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
        actions: [
          IconButton(
            icon: const Icon(
              Icons.post_add,
              color: Colors.black,
            ),
            onPressed: () {
              // Perform notification action
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PostScreen(),
                ),
              ).then((_) {
                setState(() {
                  load();
                });
              });
            },
          ),
        ],
      ),
      body: GetOwnUserPost.userPosts != null
          ? ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: GetOwnUserPost.userPosts.length,
              itemBuilder: (BuildContext context, int index) {
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
                            border: Border.all(color: Colors.black, width: 0.5),
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
                                      GetOwnUserPost.userPosts[index].category
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      height: 30,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          // Add your login logic here
                                          await oP.deletePost(GetOwnUserPost
                                              .userPosts[index].postId);
                                          load();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          backgroundColor: Colors.red,
                                        ),
                                        child: const Text(
                                          'Delete',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  GetOwnUserPost.userPosts[index].itemName
                                      .toString(),
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  GetOwnUserPost.userPosts[index].description
                                      .toString(),
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  "Budget: ${GetOwnUserPost.userPosts[index].amount.toString()}",
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: GetOwnUserPost
                                              .userPosts[index].itemImage
                                              .toString() !=
                                          null
                                      ? 300
                                      : 10,
                                  child: Container(
                                    decoration: const BoxDecoration(),
                                    child: GetOwnUserPost
                                                .userPosts[index].itemImage
                                                .toString() !=
                                            null
                                        ? Image.network(
                                            '${APILink.imageLink}${GetOwnUserPost.userPosts[index].itemImage.toString()}')
                                        : const Text(""),
                                  ),
                                ),
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
            )
          : const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(
            () {
              _currentIndex = index;
            },
          );
        },
      ),
    );
  }
}
