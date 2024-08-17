// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kwale/models/post_controler/OwnUsersPost.dart';
import 'package:kwale/models/vendorModels/AuctionModel.dart';
import 'package:kwale/screens/home_screen/post_screen/post_screen.dart';
import 'package:kwale/screens/vendor_screens/auction_detail.dart';
import 'package:kwale/screens/vendor_screens/vendor_bottom_nav_bar.dart';
import 'package:kwale/screens/widgets_screens/http_link.dart';

import 'auctions_screen.dart';

class ViewAuctions extends StatefulWidget {
  const ViewAuctions({super.key});

  @override
  _ViewAuctionsState createState() => _ViewAuctionsState();
}

class _ViewAuctionsState extends State<ViewAuctions> {
  int _currentIndex = 0;
  final TextEditingController _itemName = TextEditingController();
  final TextEditingController _itemDescription = TextEditingController();
  final Auctions auction = Auctions();
  void load() async
  {
    await auction.getVendorAuctions('test@123');
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
          'Auctions',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Image(
                image: AssetImage('assets/images/nav_bar_icons/icons8-sell-50.png',),width: 24.0,color: Colors.black),
            onPressed: () {
              // Perform notification action
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AuctionScreen(),),).
              then((_){
                setState(() {
                  load();
                });
              });
            },
          ),
        ],
      ),
      body: Auctions.auctions!=null?
      ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: Auctions.auctions.length,
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
                                Auctions.auctions[index].name.toString(),
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                height: 30,
                                child: ElevatedButton(
                                  onPressed: () async{
                                    // Add your login logic here
                                    await auction.specificAuctionDetail(Auctions.auctions[index].auctionId);
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => AuctionDetail(),),).
                                    then((_) {
                                      load();
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                  child: const Text('View Detail',),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            Auctions.auctions[index].description.toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(Auctions.auctions[index].status == true?
                            "Not Soled"
                              :
                            "Soled out",
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: Auctions.auctions[index].image1.toString()!=null? 300:10,
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              decoration: const BoxDecoration(),
                              child: Auctions.auctions[index].image1.toString()!=null?
                              Image.network('${APILink.imageLink}${Auctions.auctions[index].image1.toString()}',
                                fit: BoxFit.fill,
                              )
                                  :
                              const Text(""),
                            ),
                          ),
                          // Add more content as needed
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: SizedBox(
                              height: 30,
                              child: ElevatedButton(
                                onPressed: () async{
                                  // Add your login logic here
                                  await auction.deleteAuctions(Auctions.auctions[index].auctionId);
                                  await auction.getVendorAuctions('test@123');
                                  setState(() {});
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                                child: const Text('Remove',),
                              ),
                            ),
                          ),
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
      const Center(child: CircularProgressIndicator(color: Colors.black,),),
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
