// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:kwale/models/cart_model/AddToCart.dart';
import 'package:kwale/models/product_model/AllProducts.dart';
import 'package:kwale/models/product_model/DiscountedProducts.dart';
import 'package:kwale/models/product_model/GetAllFeaturedProducts.dart';
import 'package:kwale/models/user_model/UserInfoModel.dart';
import 'package:kwale/models/vendorModels/AuctionModel.dart';
import 'package:kwale/screens/home_screen/Widgets/category_slider.dart';
import 'package:kwale/screens/home_screen/Widgets/featured_product.dart';
import 'package:kwale/screens/home_screen/Widgets/new_arrival.dart';
import 'package:kwale/screens/home_screen/auctions/user_auction_screen.dart';
import 'package:kwale/screens/home_screen/listing_screens/all_featured_product.dart';
import 'package:kwale/screens/home_screen/listing_screens/all_hot_deals.dart';
import 'package:kwale/screens/home_screen/listing_screens/all_new_arrivals.dart';
import 'package:kwale/screens/inbox_screens/user_chat_list.dart';
import 'package:kwale/screens/widgets_screens/bottom_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:kwale/screens/widgets_screens/shared_pref.dart';

import '../../models/chat_model/ChatModel.dart';
import '../../models/user_model/UserAddress.dart';
import '../widgets_screens/flutter_toast.dart';
import '../widgets_screens/http_link.dart';
import 'Widgets/hot_deal.dart';
import 'Widgets/image_slider.dart';
import 'listing_screens/all_categories.dart';

class HomeScreen extends StatefulWidget {
  String? email, userName;
  int? refresh;
  HomeScreen({super.key, this.email,this.userName,this.refresh});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final fetchInfo _info = fetchInfo();
  final GetAllProducts _products = GetAllProducts();
  SharedPref sP = SharedPref();
  final GetFeaturedProducts fP = GetFeaturedProducts();
  final Cart cart = Cart();
  final GetUserAddress gP = GetUserAddress();
  final GetChatList chatList = GetChatList();
  final Auctions auctions = Auctions();
  final GetDiscountedProducts discountedProducts = GetDiscountedProducts();

  Future<void> googleSignInAPI() async
  {
    if(widget.userName != null && APILink.googleEmail != null)
    {
      var response = await http.post(Uri.parse('${APILink.link}Registration/loginWithGoogle'),
        body:({
          'email': widget.email,
          'username': widget.userName
        }),);
      if(response.statusCode == 200)
      {
        APILink.defaultEmail = APILink.googleEmail;

        await _info.addUser(
          APILink.googleEmail,
          APILink.googleName,
          APILink.googlePhoneNO,
          //APILink.googleDateOfBirth,
          //APILink.googleImage,
        );
        FlutterToast.showToast('You have successfully sign in.');
        //Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(),),);
      }
      else if(response.statusCode == 302){
        APILink.defaultEmail = APILink.googleEmail;
        fetchInfo.userEmail = APILink.googleEmail;
        widget.refresh=1;
        //FlutterToast.showToast('Sign in.');
        //Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(),),);
      }
      else if(response.statusCode == 500)
      {
        FlutterToast.showToast('Something went wrong. please try again.');
      }
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    googleSignInAPI();
   _products.getAllProducts();
    _info.fetchUsers(APILink.defaultEmail);
    cart.getCartItems(APILink.defaultEmail);
    chatList.getUserChatList(APILink.defaultEmail);
    auctions.allAuctions();
    load().whenComplete(() {
      setState(() {

      });
    });
  }
  load() async{
    await gP.getAddress(APILink.defaultEmail);
    await fP.featuredProducts(APILink.defaultEmail.toString());
    await discountedProducts.getAllDisProducts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Image(
              image: AssetImage('assets/images/nav_bar_icons/icons8-sell-50.png',),
            fit: BoxFit.fill,width: 24.0,color: Colors.black,),
          onPressed: () {
            // Perform search action
            //Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchScreen(),),);
            Navigator.push(context, MaterialPageRoute(builder: (context) => const UserViewAllAuctions(),),);
          },
        ),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const UserChatList(),),)
                  .then((value) {setState(() {});});
            },
            icon: const Icon(Icons.messenger_outline_outlined), color: Colors.black,),
        ],
        title: const Text(
          'Kwale',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
     // drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10,),
            //Images Slider
            SizedBox(
              //  height: 400,
                width: MediaQuery.of(context).size.width,
                child: const ImageSlider(),
            ),
            //Categories
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  const Text('Categories',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  const Spacer(),
                  TextButton(
                    onPressed: (){
                      // Add your forgot password logic here
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AllCategories(),),)
                          .then((value) {setState(() {});});
                    },
                    child: const Text("View all", style: TextStyle(fontSize: 18,color: Colors.red),),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            const CategorySlider(),
            //Featured Products
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  const Text('Featured Products',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  const Spacer(),
                  TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AllFeaturedProducts(),),)
                          .then((_) {setState(() {});});
                    },
                    child: const Text("View all", style: TextStyle(fontSize: 18,color: Colors.red),),
                  ),
                ],
              ),
            ),
           const FeaturedProducts(),
            //Vendors
            const SizedBox(height: 0.0,),
            // const SizedBox(height: 10,),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //   child: Row(
            //     children: [
            //       const Text('Vendors',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            //       const Spacer(),
            //       TextButton(
            //         onPressed: (){
            //           Navigator.push(context, MaterialPageRoute(builder: (context) => AllVendors(),),);
            //         },
            //         child: const Text("View all", style: TextStyle(fontSize: 18,color: Colors.red),),
            //       ),
            //     ],
            //   ),
            // ),
            // //  const SizedBox(height: 10,),
            // const VendorScreen(),
            //New arrival
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  const Text('New Arrivals',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  const Spacer(),
                  TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AllNewArrivals(),),)
                          .then((value) {setState(() {});});
                    },
                    child: const Text("View all", style: TextStyle(fontSize: 18,color: Colors.red),),
                  ),
                ],
              ),
            ),
            const NewArrival(),
            //Brands
            const SizedBox(height: 0.0,),
            // const SizedBox(height: 10,),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //   child: Row(
            //     children: [
            //       const Text('Brands',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            //       const Spacer(),
            //       TextButton(
            //         onPressed: (){
            //           Navigator.push(context, MaterialPageRoute(builder: (context) => const AllBrands(),),);
            //         },
            //         child: const Text("View all", style: TextStyle(fontSize: 18,color: Colors.red),),
            //       ),
            //     ],
            //   ),
            // ),
            // const BrandScreen(),
            //Hot Deals
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  const Text('Hot Deals',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  const Spacer(),
                  TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AllHotDeals(),),);
                    },
                    child: const Text("View all", style: TextStyle(fontSize: 18,color: Colors.red),),
                  ),
                ],
              ),
            ),
            const HotDeals(),
            //const SizedBox(height: 10,),

            // SizedBox(
            //   width: MediaQuery.of(context).size.width,
            //   child: const Padding(
            //     padding:  EdgeInsets.symmetric(vertical: 8.0),
            //     child:  Image(
            //       image: AssetImage('assets/images/splash_screen.png'),
            //     ),
            //   ),
            // ),

            const SizedBox(height: 10,),
          ],
        ),
      ),
      //Bottom Navigation Bar
      bottomNavigationBar: BottomNavBar(
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
