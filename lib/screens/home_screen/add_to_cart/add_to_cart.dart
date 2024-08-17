// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kwale/models/cart_model/AddToCart.dart';
import 'package:kwale/models/product_model/GetAllFeaturedProducts.dart';
import 'package:kwale/models/product_model/GetSpecificProduct.dart';
import 'package:kwale/models/user_model/UserInfoModel.dart';
import 'package:kwale/models/vendorModels/GetSpecificVendor.dart';
import 'package:kwale/screens/home_screen/add_to_cart/cart_screen.dart';
import 'package:kwale/screens/home_screen/listing_screens/vendorsallProduct.dart';
import 'package:kwale/screens/widgets_screens/rating_bar.dart';
import '../../../models/chat_model/ChatModel.dart';
import '../../../models/product_model/ProductDetailImages.dart';
import '../../../models/vendorModels/AuctionModel.dart';
import '../../inbox_screens/user_message.dart';
import '../../widgets_screens/http_link.dart';

class AddToCartScreen extends StatefulWidget {
  final String? productId;
  final String? val;
  const AddToCartScreen({super.key, this.productId,this.val});

  @override
  AddToCartScreenState createState() => AddToCartScreenState();
}

class AddToCartScreenState extends State<AddToCartScreen> {
  final String _selectedSize = '';
  final GetSpecificPro pro = GetSpecificPro();
  final GetFeaturedProducts fP = GetFeaturedProducts();
  final GetVendor sP = GetVendor();
  final Cart cart = Cart();
  final Auctions auction = Auctions();
  final fetchInfo _fetchInfo = fetchInfo();

  final GetChatList chatList = GetChatList();
  int ref = 0;

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
    await fP.getSpecificFeature(APILink.defaultEmail,widget.productId.toString());
     //await sP.getSpecificVendor(GetSpecificPro.specificProd[0].email.toString());
     await _fetchInfo.fetchVendors(GetSpecificPro.specificProd[0].email.toString());
    ref = 1;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async{
          Navigator.pop(context);
          return true;
        },
        child: ref==1?//GetSpecificPro.specificProd.length!=null?
        SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(12),bottomLeft: Radius.circular(12)),
                      image:
                      GetSpecificPro.specificProd[0].productImage !=
                          null
                          ? DecorationImage(
                        image: NetworkImage(
                            "${APILink.imageLink}${GetSpecificPro.specificProd[0].productImage}"),
                        fit: BoxFit.fill,
                      )
                          :
                      const DecorationImage(
                        image: AssetImage(
                            'assets/images/featured_images/shirt.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  //Image
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const Spacer(),
                        IconButton(
                          icon: Icon(
                            Icons.favorite_border_sharp,
                            color: GetFeaturedProducts.isFeaturedPro == true
                                ?
                            Colors.red
                                :
                            Colors.black,
                          ),
                          onPressed: () async{
                            // Move to Cart Screen
                            await fP.addOrRemoveFeatured(
                              fetchInfo.userEmail.toString(),
                              GetSpecificPro.specificProd[0].productID.toString(),
                              GetSpecificPro.specificProd[0].name.toString(),
                              GetSpecificPro.specificProd[0].description.toString(),
                              GetSpecificPro.specificProd[0].price.toString(),
                              GetSpecificPro.specificProd[0].stockQuantity.toString(),
                              GetSpecificPro.specificProd[0].category.toString(),
                              GetSpecificPro.specificProd[0].productImage.toString(),
                              GetSpecificPro.specificProd[0].productRating.toString(),
                            );
                            GetFeaturedProducts.isFeaturedPro = !GetFeaturedProducts.isFeaturedPro;
                            setState(() {

                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  children: [
                    Text(
                      GetSpecificPro.specificProd[0].name != null
                          ? GetSpecificPro.specificProd[0].name.toString()
                          : "Product with no Name",
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      GetSpecificPro.specificProd[0].price != null
                          ? GetSpecificPro.specificProd[0].price.toString()
                          : "",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),
              //Available Sizes
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  'Available Sizes:',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              //different Sizes
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    const Spacer(),
                    GetSpecificPro.specificProd[0].small==true?
                    ChoiceChip(
                      padding: const EdgeInsets.all(18),
                      label: const Text('S'),
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      selected: _selectedSize == 4.toString(),
                      onSelected: (selected) {
                        setState(() {
                          //_selectedSize = size;
                        });
                      },
                    ):const Text(''),
                    const Spacer(),
                    GetSpecificPro.specificProd[0].medium==true?
                    ChoiceChip(
                      padding: const EdgeInsets.all(18),
                      label: const Text('M'),
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      selected: _selectedSize == 4.toString(),
                      onSelected: (selected) {
                        setState(() {
                          //_selectedSize = size;
                        });
                      },
                    ):const Text(''),
                    const Spacer(),
                    GetSpecificPro.specificProd[0].large==true?
                    ChoiceChip(
                      padding: const EdgeInsets.all(18),
                      label: const Text('L'),
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      selected: _selectedSize == 4.toString(),
                      onSelected: (selected) {
                        setState(() {
                          //_selectedSize = size;
                        });
                      },
                    ):const Text(''),
                    const Spacer(),
                    GetSpecificPro.specificProd[0].xLarge==true?
                    ChoiceChip(
                      padding: const EdgeInsets.all(18),
                      label: const Text(
                        'XL',
                        textAlign: TextAlign.center,
                      ),
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      selected: _selectedSize == 4.toString(),
                      onSelected: (selected) {
                        setState(() {
                          //_selectedSize = size;
                        });
                      },
                    ):const Text(''),
                    const Spacer(),
                  ],
                ),
              ), //detailed images
              GetProductDetailedImages.prodImages.isNotEmpty?
              Center(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      children: [
                        Container(
                          height: 144,
                          width: 144,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 0.5),
                            borderRadius: BorderRadius.circular(12),
                            //const BorderRadius.only(bottomRight: Radius.circular(12),bottomLeft: Radius.circular(12)),
                            image:
                            GetProductDetailedImages.prodImages[0].image1 !=
                                null
                                ? DecorationImage(
                              image: NetworkImage(
                                  "${APILink.imageLink}${GetProductDetailedImages.prodImages[0].image1}"),
                              fit: BoxFit.fill,
                            )
                                :
                            const DecorationImage(
                              image: AssetImage(
                                  'assets/images/featured_images/shirt.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        Container(
                          height: 144,
                          width: 144,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 0.5),
                            borderRadius: BorderRadius.circular(12),
                            // const BorderRadius.only(bottomRight: Radius.circular(12),bottomLeft: Radius.circular(12)),
                            image:
                            GetProductDetailedImages.prodImages[0].image2 !=
                                null
                                ? DecorationImage(
                              image: NetworkImage(
                                  "${APILink.imageLink}${GetProductDetailedImages.prodImages[0].image2}"),
                              fit: BoxFit.fill,
                            )
                                :
                            const DecorationImage(
                              image: AssetImage(
                                  'assets/images/featured_images/shirt.png'
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        Container(
                          height: 144,
                          width: 144,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 0.5),
                            borderRadius: BorderRadius.circular(12),
                            //BorderRadius.only(bottomRight: Radius.circular(12),bottomLeft: Radius.circular(12)),
                            image:
                            GetProductDetailedImages.prodImages[0].image3 !=
                                null
                                ? DecorationImage(
                              image: NetworkImage(
                                  "${APILink.imageLink}${GetProductDetailedImages.prodImages[0].image3}"),
                              fit: BoxFit.fill,
                            )
                                :
                            const DecorationImage(
                              image: AssetImage(
                                  'assets/images/featured_images/shirt.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],),
                  ),
                ),
              ):const SizedBox(height: 0.0,),
              const SizedBox(height: 16),
              //Description
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  'Description:',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  GetSpecificPro.specificProd[0].description != null
                      ? GetSpecificPro.specificProd[0].description.toString()
                      : "No Description",
                ),
              ),
              const SizedBox(height: 16),
              //Reviews
              const SizedBox(height: 0.0),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    fetchInfo.venImage!=null?
                     GestureDetector(
                       onTap: (){
                         Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (context) => ViewVendorAllProducts(email: fetchInfo.venEmail.toString(),),
                           ),
                         );
                       },
                       child: CircleAvatar(
                          backgroundColor: const Color(0xffFFFFC2),
                          radius: 40,
                          backgroundImage: NetworkImage(
                              '${APILink.imageLink}${fetchInfo.venImagePost.toString()}') // GetVendor.specificVendor[0].profileImage.toString()
                    ),
                     ):
                    const CircleAvatar(
                        backgroundColor: Color(0xffFFFFC2),
                        radius: 40,
                        backgroundImage: AssetImage(
                            'assets/images/profile/avatar_icon.png') // Replace with your default avatar image.
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(fetchInfo.venName!=null?//GetVendor.specificVendor[0].labelName
                      fetchInfo.venName.toString()://GetVendor.specificVendor[0].labelName.toString()
                      "no username",
                      style: const TextStyle(fontSize: 18),),
                    const Spacer(),
                    Column(
                      children: [
                        AddRatingBar(
                            rating: GetSpecificPro.specificProd[0].productRating!=null?
                            double.parse(GetSpecificPro.specificProd[0].productRating.toString())
                                :
                            1.0
                        ),
                         const SizedBox(height: 10,),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: SizedBox(
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () async{
                                //await sP.getSpecificVendor();
                                await chatList.addConversationList(
                                  //GetVendor.specificVendor[0].email,
                                  fetchInfo.venEmail,
                                  //GetVendor.specificVendor[0].labelName.toString(),
                                  fetchInfo.venName,
                                  fetchInfo.userEmail ?? APILink.googleEmail,
                                  fetchInfo.name,
                                  //GetVendor.specificVendor[0].profileImage,
                                  fetchInfo.venImagePost,
                                  fetchInfo.imagePost,
                                  //Auctions.auctions[index].email,
                                );
                                Navigator.push(context, MaterialPageRoute(builder: (context) => UserChatMessage(
                                  name: fetchInfo.venName,//GetVendor.specificVendor[0].labelName.toString(),
                                  email: fetchInfo.venEmail,//GetVendor.specificVendor[0].email,
                                  image: "${APILink.imageLink}${fetchInfo.venImagePost}",//GetVendor.specificVendor[0].profileImage
                                  message: "${APILink.imageLink}${GetSpecificPro.specificProd[0].productImage.toString()}",
                                )));
                                setState(() {});
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
                        ),
                        // IconButton(
                        //     onPressed: (){
                        //       shareWidget("Share Item");
                        //     },
                        //     icon: const Icon(Icons.share)),
                      ],
                    ),
                  ],
                ),
              ), //${widget.product.rating}
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    const Text(
                      'Total Price:',
                      style: TextStyle(fontSize: 18),
                    ),
                    const Spacer(),
                    Text(
                      GetSpecificPro.specificProd[0].discountAmount != null
                          ?
                      "${GetSpecificPro.specificProd[0].discountAmount.toString()}\$"
                          :
                      GetSpecificPro.specificProd[0].price != null
                          ?
                      "${GetSpecificPro.specificProd[0].price}\$"
                          :
                      "",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              //Add to Cart Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(33)
                  ),
                  child: ElevatedButton(
                    onPressed: () async{
                      // Add to cart logic here
                      final Cart c = Cart();
                      await cart.addItemToCart(
                          APILink.defaultEmail,
                          GetSpecificPro.specificProd[0].productID,
                          GetSpecificPro.specificProd[0].name,
                          GetSpecificPro.specificProd[0].productImage,
                          1,
                          GetSpecificPro.specificProd[0].discountAmount ?? GetSpecificPro.specificProd[0].price,
                          'null',
                        GetSpecificPro.specificProd[0].email
                      );
                      await c.getCartItems(APILink.defaultEmail);
                      //await sP.specificProducts(widget.productId);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartScreen(productId: widget.productId,),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(33)
                        )
                    ),
                    child: const Text('Add to Cart'),
                  ),
                ),
              ),

            ],
          ),
        ):
        const Center(child: CircularProgressIndicator(color: Colors.red,),),
      ),
    );
  }
  // shareWidget(share) async{
  //   if(share == "Share Item") {
  //     await Share.share(
  //       subject:"${GetSpecificPro.specificProd[0].name}",
  //       "${APILink.imageLink}${GetSpecificPro.specificProd[0].productImage}",
  //     );
  //   }
  // }
}
