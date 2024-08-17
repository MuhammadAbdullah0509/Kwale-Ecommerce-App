import 'package:flutter/material.dart';
import 'package:kwale/screens/home_screen/Widgets/featured_product.dart';
import 'package:kwale/screens/home_screen/listing_screens/all_featured_product.dart';
import 'package:kwale/screens/home_screen/listing_screens/wishlish_screen.dart';
import 'package:kwale/screens/profile_screen/profile_screen.dart';

import '../home_screen/add_to_cart/cart_screen.dart';
import '../home_screen/home_screen.dart';
import '../home_screen/post_screen/view_post.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (onTap){
        if(onTap == 0){
          // Navigator.pushAndRemoveUntil(context,
          //     MaterialPageRoute(builder: (BuildContext context) {
          //       return HomeScreen();
          //     }), (r) {
          //       return false;
          //     });
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),),);
        }
        if(onTap == 1){
          //Navigator.push(context, MaterialPageRoute(builder: (context) => const WishlistScreen(),),);
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AllFeaturedProducts(),),);
        }
        if(onTap == 2){
          Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(),),);
        }
        if(onTap == 3){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewPost(),),);
        }
        if(onTap == 4){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen(),),);
        }
      },
      showSelectedLabels: false, // Hide the labels
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined  ,color: Colors.black,),
          label: '',//'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border_outlined,color: Colors.black,),
          label: '',//'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined,color: Colors.black,),
          label: '',//'cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.post_add,color: Colors.black,),
          label: '',//'cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_2_outlined,color: Colors.black,),
          label: '',//'Profile',
        ),
      ],
    );
  }
  // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
  // return HomeScreen();
  // }), (r){
  // return false;
  // });
}
