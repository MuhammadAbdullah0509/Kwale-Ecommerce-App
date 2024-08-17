import 'package:flutter/material.dart';
import 'package:kwale/models/product_model/DiscountedProducts.dart';
import 'package:kwale/models/vendorModels/AuctionModel.dart';
import 'package:kwale/models/vendorModels/GetSpecificVendor.dart';
import 'package:kwale/models/vendorModels/VendorProducts.dart';
import 'package:kwale/screens/inbox_screens/chat_lists.dart';
import 'package:kwale/screens/vendor_screens/upload_items.dart';
import 'package:kwale/screens/vendor_screens/vendor_bottom_nav_bar.dart';
import 'package:kwale/screens/vendor_screens/vendor_product_detail.dart';
import 'package:kwale/screens/widgets_screens/http_link.dart';

import '../../models/chat_model/ChatModel.dart';
import '../../models/user_model/UserInfoModel.dart';
import '../widgets_screens/rating_bar.dart';

class VendorDashboard extends StatefulWidget {
  final String? email;
  const VendorDashboard({super.key,this.email});

  @override
  VendorDashboardState createState() => VendorDashboardState();
}

class VendorDashboardState extends State<VendorDashboard> {
  int _currentIndex = 0;
  final GetVendor getVendor = GetVendor();
  final AllVendorProducts vendorProducts = AllVendorProducts();
  final Auctions auctions = Auctions();
  //final fetchInfo _fetchInfo = fetchInfo();
  final GetChatList chatList = GetChatList();
  final GetDiscountedProducts discountedProducts = GetDiscountedProducts();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load().whenComplete(() {
      setState(() {

      });
    });
  }
  load() async
  {
    await vendorProducts.getVendorProducts(APILink.vendorEmail);//fetchInfo.userEmail
    //await getVendor.getSpecificVendor(APILink.vendorEmail);
    await auctions.getVendorAuctions(fetchInfo.venEmail);
    await chatList.getVendorChatList(APILink.vendorEmail);//APILink.vendorEmail//'qk866231@gmail.com'
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading:  IconButton(
          icon: const Icon(Icons.drive_folder_upload_rounded, color: Colors.black,),
          onPressed: () {
            // Perform notification action
            Navigator.push(context, MaterialPageRoute(builder: (context) => const VendorUploadItems(),),).
            then((value) {
              setState(() {});
            });
          },
        ),
        title: const Text(
          'Vendor Dashboard',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [

          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatList(),),);
            },
            icon: const Icon(Icons.chat), color: Colors.black,),
        ],
      ),
      body:AllVendorProducts.vendorProducts.isNotEmpty?
      GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 1.0),
        ),
        itemCount: AllVendorProducts.vendorProducts.length,
        itemBuilder: (BuildContext context, int index) {
          return  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              //height: 250,//MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                //color: Colors.yellow[200],
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(width: 1),
              ),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //images and favorite icon
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height*1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: AllVendorProducts.vendorProducts[index].productImage!=null?
                        DecorationImage(
                          image: NetworkImage('${APILink.imageLink}${AllVendorProducts.vendorProducts[index].productImage.toString()}'),
                          fit: BoxFit.fill,
                        )
                            :
                        const DecorationImage(
                          image: AssetImage('assets/images/featured_images/shirt.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  //const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 6),
                    child: Text(
                      AllVendorProducts.vendorProducts[index].name.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        AddRatingBar(
                          rating:AllVendorProducts.vendorProducts[index].productRating!.toDouble(),
                          size: 8,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AllVendorProducts.vendorProducts[index].stockQuantity! > 0?
                        "Available Stock: ${AllVendorProducts.vendorProducts[index].stockQuantity}"
                            :
                        "Out of stock",//item.itemDescription,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child:Text(AllVendorProducts.vendorProducts[index].price!=null?
                    "Price: ${AllVendorProducts.vendorProducts[index].price}"
                        :
                    "",
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: SizedBox(
                        height: 30,
                        child: ElevatedButton(
                          onPressed: () async{
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>VendorDetailProductScreen(
                              productId: AllVendorProducts.vendorProducts[index].productID.toString(),
                            )));
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
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
          );
          //buildCategoryCard(item[index],itemName[index]);
        },
      )
          :
      const Center(child: Center(child:
      //AllVendorProducts.vendorProducts.length==0?const Text("No Item"):
      CircularProgressIndicator(color: Colors.red,),),),
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
  Widget buildCategoryCard(String image,String name) {
    return Container(
      height: 400,//MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.yellow[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child:  Column(
        children: [
          //images and favorite icon
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Align(alignment: Alignment.topRight,child: Icon(Icons.favorite_border)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
            child: Text(name),
          ),
          //Rating
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Icon(Icons.star_border),
                SizedBox(width: 2,),
                Text('0.0'),
              ],
            ),
          ),
          //Payment
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
            child: Row(
              children: [
                Text("120.00\$"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


