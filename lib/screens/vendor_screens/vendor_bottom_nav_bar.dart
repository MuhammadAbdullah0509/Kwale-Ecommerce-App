// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kwale/models/vendorModels/VendorProducts.dart';
import 'package:kwale/screens/profile_screen/profile_screen.dart';
import 'package:kwale/screens/vendor_screens/all_post.dart';
import 'package:kwale/screens/vendor_screens/auctions_screen.dart';
import 'package:kwale/screens/vendor_screens/vendor_dashboard.dart';
import 'package:kwale/screens/vendor_screens/vendor_profile.dart';
import 'package:kwale/screens/vendor_screens/view_auction.dart';


class VendorNevBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const VendorNevBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (onTap) async{
        if(onTap == 0){
          // Navigator.pushAndRemoveUntil(context,
          //     MaterialPageRoute(builder: (BuildContext context) {
          //       return HomeScreen();
          //     }), (r) {
          //       return false;
          //     });
          //AllVendorProducts vP = AllVendorProducts();
          //await vP.getVendorProducts('');
          Navigator.push(context, MaterialPageRoute(builder: (context) => VendorDashboard(),),);
        }
        if(onTap == 1){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AllPost(),),);
        }
        if(onTap == 2){

          Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewAuctions(),),);
        }
        if(onTap == 3){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const VendorProfile(),),);
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
          icon: Icon(Icons.post_add,color: Colors.black,),
          label: '',//'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Image(image: AssetImage('assets/images/nav_bar_icons/icons8-sell-50.png',),width: 24.0,color: Colors.black),
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
