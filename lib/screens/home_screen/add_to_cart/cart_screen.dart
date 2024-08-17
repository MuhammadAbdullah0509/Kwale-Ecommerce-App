import 'package:flutter/material.dart';
import 'package:kwale/models/cart_model/AddToCart.dart';
import 'package:kwale/models/product_model/GetSpecificProduct.dart';
import 'package:kwale/models/user_model/UserAddress.dart';
import 'package:kwale/screens/home_screen/add_to_cart/address_screen.dart';
import 'package:kwale/screens/home_screen/add_to_cart/payment_screen.dart';
import 'package:kwale/screens/widgets_screens/flutter_toast.dart';
import 'package:kwale/screens/widgets_screens/http_link.dart';
import '../../widgets_screens/bottom_nav_bar.dart';

class CartScreen extends StatefulWidget {
  String? productId;
  CartScreen({super.key, this.productId});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int quantity = 1;
  int t_amount = 0;
  int totalPrice = 0;
  final Cart cart = Cart();
  //final GetUserAddress gP = GetUserAddress();
  final GetSpecificPro specificPro= GetSpecificPro();
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
        title: const Text('Cart', style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: Cart.cartItem.length!=null?
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: //Cart.cartItem.length!=null?
            ListView.builder(
              itemCount: Cart.cartItem.length,
              itemBuilder: (context, index) {
                return _buildCartItem(index);//cartItems[index]
              },
            )
                //:
            //const Center(child: Text("No Item"),),
          ),
          //Address
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AddressScreen(),),).
                then((value) {
                  setState(() {
                  });
                });
              },
              child: Container(
                //color: Colors.grey[200],
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 0.2)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: SizedBox(
                        child: Row(
                          children: [
                            Text(GetUserAddress.userAddress.isNotEmpty?
                            "${GetUserAddress.userAddress[0].street},"
                                " ${GetUserAddress.userAddress[0].city}, "
                                "${GetUserAddress.userAddress[0].phoneNo}"
                                :
                                'Delivery Address'),
                            const Spacer(),
                            const Icon(Icons.arrow_forward_ios_outlined),
                          ],
                        ),
                      ),
                    ),
                    // const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10,),
          Container(
            //padding: EdgeInsets.all(16.0),
            //height: 120,
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      const Text(
                        'Total Amount:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(Cart.tAmount!=null?
                        '${Cart.tAmount.toString()}\$':"",
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
               const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement payment logic here
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen(
                          amount: Cart.tAmount.toString(),
                          vemail: APILink.vendorEmail,
                          address:  "${GetUserAddress.userAddress[0].street},"
                              " ${GetUserAddress.userAddress[0].city}, "
                              "${GetUserAddress.userAddress[0].phoneNo}",
                        ),),);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text('Proceed to Payment'),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
              ],
            ),
          ),
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
                child: Cart.cartItem[index].productImage!=null?
                Image(
                  image: NetworkImage('${APILink.imageLink}${Cart.cartItem[index].productImage.toString()}'),
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
              const SizedBox(width: 10,),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(Cart.cartItem[index].productName!=null?
                        Cart.cartItem[index].productName.toString()
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
                    Text(Cart.cartItem[index].totalAmount!=null?
                    "${Cart.cartItem[index].totalAmount} \$"
                        :
                    '0.0\$',//\$${(item.price * item.quantity).toStringAsFixed(2)}
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),
            ],
          ),
          //delete cart item
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 30,
                child: ElevatedButton(
                  onPressed: () async{
                    //await specificPro.specificProducts(Cart.cartItem[index].productId);
                    GetUserAddress.userAddress.isNotEmpty
                        ?
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen(
                      amount: Cart.cartItem[index].totalAmount,
                      id: Cart.cartItem[index].productId,
                      quantity: Cart.cartItem[index].quantity,
                      vemail: Cart.cartItem[index].vemail,
                      image: Cart.cartItem[index].productImage,
                      address:  "${GetUserAddress.userAddress[0].street},"
                          " ${GetUserAddress.userAddress[0].city}, "
                          "${GetUserAddress.userAddress[0].phoneNo}",
                      name: Cart.cartItem[index].productName,
                    ),),)
                        .then((value) {setState(() {});})
                        :
                    FlutterToast.showToast("Please Select the Address");
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Buy now',),
                ),
              ),
              const SizedBox(width: 20,),
              SizedBox(
                height: 30,
                child: ElevatedButton(
                  onPressed: () async{
                    // Add your login logic here
                    await cart.removeCartItems(APILink.defaultEmail, Cart.cartItem[index].productId);
                    await cart.getCartItems(APILink.defaultEmail);
                    await cart.getTotalAmount(APILink.defaultEmail);
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
            ],
          ),
        ],
      ),
    );
  }
}
