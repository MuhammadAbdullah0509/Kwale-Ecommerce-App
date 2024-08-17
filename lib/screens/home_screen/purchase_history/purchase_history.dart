import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kwale/models/cart_model/AddToCart.dart';
import 'package:kwale/models/cart_model/PurchaseHistory.dart';
import 'package:kwale/models/product_model/AllProducts.dart';
import 'package:kwale/models/product_model/GetSpecificProduct.dart';
import 'package:kwale/models/user_model/UserAddress.dart';
import 'package:kwale/screens/home_screen/add_to_cart/address_screen.dart';
import 'package:kwale/screens/home_screen/add_to_cart/payment_screen.dart';
import 'package:kwale/screens/widgets_screens/flutter_toast.dart';
import 'package:kwale/screens/widgets_screens/http_link.dart';
import 'package:kwale/screens/widgets_screens/rating_bar.dart';
import '../../widgets_screens/bottom_nav_bar.dart';

class PurchaseHistory extends StatefulWidget {
  String? productId;
  PurchaseHistory({super.key, this.productId});

  @override
  State<PurchaseHistory> createState() => _PurchaseHistoryState();
}

class _PurchaseHistoryState extends State<PurchaseHistory> {
  int quantity = 1;
  int t_amount = 0;
  int totalPrice = 0;
  final Cart cart = Cart();
  //final GetUserAddress gP = GetUserAddress();
  final GetSpecificPro specificPro= GetSpecificPro();
  final GetPurchases getPurchases = GetPurchases();
  final GetAllProducts getAllProducts = GetAllProducts();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quantity = 1;
    t_amount = 0;
    totalPrice = 0;
    load();
  }
  void load() async{
    //await sP.specificProducts(widget.productId);
    await cart.getCartItems(APILink.defaultEmail);
    await cart.getTotalAmount(APILink.defaultEmail);
    await getPurchases.getPurchaseItems(APILink.defaultEmail);
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
        title: const Text('History', style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: GetPurchases.purchaseItem.length!=null?
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: //Cart.cartItem.length!=null?
            ListView.builder(
              itemCount: GetPurchases.purchaseItem.length,
              itemBuilder: (context, index) {
                return _buildCartItem(index);//cartItems[index]
              },
            )
                //:
            //const Center(child: Text("No Item"),),
          ),
          const SizedBox(height: 10,),
        ],
      )
          :
        const Center(child: Text("No Item"),),
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
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
                child: GetPurchases.purchaseItem[index].productImage!=null?
                Image(
                  image: NetworkImage('${APILink.imageLink}${GetPurchases.purchaseItem[index].productImage.toString()}'),
                  //fit: BoxFit.cover,
                  height: 74,
                )
                    :
                const Center(child: CircleAvatar(
                  radius: 74,
                    backgroundColor: Colors.white70,
                    child: Text("No Image Available",style: TextStyle(color: Colors.black),textAlign: TextAlign.center,),),),
              ),
              const SizedBox(width: 10,),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(GetPurchases.purchaseItem[index].productName!=null?
                        GetPurchases.purchaseItem[index].productName.toString()
                            :
                          'no name',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(GetPurchases.purchaseItem[index].delivered==false?
                    "In Progress"
                        :
                    'Received',
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),

            ],
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RatingBar.builder(
                itemSize: 25,
                initialRating: 1,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                  getAllProducts.updateProductRating(GetPurchases.purchaseItem[index].productID, rating);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
