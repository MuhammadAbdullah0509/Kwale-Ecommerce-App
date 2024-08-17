// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kwale/models/cart_model/AddToCart.dart';
import 'package:kwale/models/product_model/GetSpecificProduct.dart';
import 'package:kwale/models/user_model/UserAddress.dart';
import 'package:kwale/models/vendorModels/AuctionModel.dart';
import 'package:kwale/screens/home_screen/add_to_cart/address_screen.dart';
import 'package:kwale/screens/home_screen/add_to_cart/payment_screen.dart';
import 'package:kwale/screens/widgets_screens/flutter_toast.dart';
import 'package:kwale/screens/widgets_screens/http_link.dart';

class AuctionDetail extends StatefulWidget {
  String? productId;
  AuctionDetail({super.key, this.productId});

  @override
  State<AuctionDetail> createState() => _AuctionDetailState();
}

class _AuctionDetailState extends State<AuctionDetail> {
  final Auctions auctions = Auctions();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }
  void load() async{

    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context); // Replace with desired action
          },
        ),
        title: const Text('Auction Detail', style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body:SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(bottomRight: Radius.circular(12),bottomLeft: Radius.circular(12)),
                image:
                Auctions.specificAuction[0].image1 !=
                    null
                    ? DecorationImage(
                  image: NetworkImage(
                      "${APILink.imageLink}${Auctions.specificAuction[0].image1}"),
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
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(Auctions.specificAuction[0].name.toString(),
                style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 12),
              child: Text(Auctions.specificAuction[0].description.toString(),
                style: const TextStyle(fontSize: 18),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    children: [
                      Container(
                        height: 124,
                        width: 124,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(bottomRight: Radius.circular(12),bottomLeft: Radius.circular(12)),
                          image:
                          Auctions.specificAuction[0].image1 !=
                              null
                              ? DecorationImage(
                            image: NetworkImage(
                                "${APILink.imageLink}${Auctions.specificAuction[0].image1}"),
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
                        height: 124,
                        width: 124,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(bottomRight: Radius.circular(12),bottomLeft: Radius.circular(12)),
                          image:
                          Auctions.specificAuction[0].image2 !=
                              null
                              ? DecorationImage(
                            image: NetworkImage(
                                "${APILink.imageLink}${Auctions.specificAuction[0].image2}"),
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
                        height: 124,
                        width: 124,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(bottomRight: Radius.circular(12),bottomLeft: Radius.circular(12)),
                          image:
                          Auctions.specificAuction[0].image3 !=
                              null
                              ? DecorationImage(
                            image: NetworkImage(
                                "${APILink.imageLink}${Auctions.specificAuction[0].image2}"),
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
            ),
            const SizedBox(height: 20),
            //Remove Auctions
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
                    await auctions.deleteAuctions(Auctions.specificAuction[0].auctionId);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(33)
                      )
                  ),
                  child: const Text('Remove'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(int index) {//CartItem item
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 20,),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Auctions.specificAuction[index].image1!=null?
                Image(
                  image: NetworkImage('${APILink.imageLink}${Auctions.specificAuction[index].image1.toString()}'),
                  //fit: BoxFit.cover,
                  height: 74,
                )
                    :
                const Image(
                  image: AssetImage('assets/images/profile/avatar_icon.png',),
                  //fit: BoxFit.cover,
                  height: 74,
                ),
              ),
              const SizedBox(width: 20,),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(Auctions.specificAuction[index].name!=null?
                        Auctions.specificAuction[index].name.toString()
                            :
                        'no name',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),
                        ),
                      ],
                    ),
                    //const SizedBox(height: 8),
                    // Row(
                    //   children: [
                    //     IconButton(onPressed: (){
                    //       setState(() {
                    //         if(Cart.cartItem[index].quantity !> 1) {
                    //           Cart.cartItem[index].quantity = Cart.cartItem[index].quantity! - 1;
                    //           quantity -= 1;
                    //           t_amount =t_amount - Cart.cartItem[index].totalAmount!;
                    //           Cart.cartItem[index].totalAmount = t_amount;
                    //           //Cart.cartItem[index].totalAmount = Cart.cartItem[index].totalAmount!*quantity;
                    //           //Cart.cartItem[index].totalAmount = Cart.cartItem[index].totalAmount! * Cart.cartItem[index].quantity!;
                    //           //totalPrice = Cart.cartItem[index].totalAmount!;
                    //         }
                    //         else
                    //         {
                    //           FlutterToast.showToast('Quantity is not less then 1');
                    //         }
                    //       });
                    //     }, icon: const Icon(Icons.minimize_outlined,size: 20,)),
                    //     Text(Cart.cartItem[index].quantity!=null?
                    //     Cart.cartItem[index].quantity.toString()
                    //         :
                    //     quantity.toString(),
                    //       style: const TextStyle(fontSize: 16),
                    //     ),
                    //     IconButton(onPressed: (){
                    //       setState(() {
                    //         Cart.cartItem[index].quantity = Cart.cartItem[index].quantity! + 1;
                    //         quantity += 1;
                    //         t_amount = Cart.cartItem[index].totalAmount!;
                    //         //Cart.cartItem[index].totalAmount = Cart.cartItem[index].totalAmount!*quantity;
                    //         //t_amount =t_amount + Cart.cartItem[index].totalAmount!;
                    //         Cart.cartItem[index].totalAmount = Cart.cartItem[index].totalAmount!*quantity;
                    //         //Cart.cartItem[index].totalAmount = t_amount;
                    //         //Cart.cartItem[index].totalAmount = Cart.cartItem[index].totalAmount!*Cart.cartItem[index].quantity!;
                    //         print(t_amount);
                    //         print(Cart.cartItem[index].totalAmount);
                    //       });
                    //     }, icon: const Icon(Icons.add,size: 20,)),
                    //   ],
                    // ),

                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(Auctions.specificAuction[index].description!=null?
                    "${Auctions.specificAuction[index].description}"
                        :
                    '',
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),
            ],
          ),
          //delete cart item
          SizedBox(
            height: 30,
            child: ElevatedButton(
              onPressed: () async{
                // Add your login logic here
                setState(() {

                });
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
        ],
      ),
    );
  }
}
