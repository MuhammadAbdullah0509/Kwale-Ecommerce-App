// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kwale/models/product_model/DiscountedProducts.dart';
import 'package:kwale/models/vendorModels/AuctionModel.dart';
import 'package:kwale/models/vendorModels/GetSpecificVendor.dart';
import 'package:kwale/models/vendorModels/VendorProducts.dart';
import 'package:kwale/screens/vendor_screens/vendor_product_detail.dart';
import 'package:kwale/screens/widgets_screens/http_link.dart';

import '../../../models/product_model/GetAllFeaturedProducts.dart';
import '../../../models/product_model/GetSpecificProduct.dart';
import '../../../models/user_model/UserInfoModel.dart';
import '../../widgets_screens/flutter_toast.dart';
import '../../widgets_screens/rating_bar.dart';
import '../add_to_cart/add_to_cart.dart';


class ViewVendorAllProducts extends StatefulWidget {
  String? email;
  ViewVendorAllProducts({super.key,this.email});

  @override
  _ViewVendorAllProductsState createState() => _ViewVendorAllProductsState();
}

class _ViewVendorAllProductsState extends State<ViewVendorAllProducts> {
  int _currentIndex = 0;
  //final GetVendor getVendor = GetVendor();
  final AllVendorProducts vendorProducts = AllVendorProducts();
  //final Auctions auctions = Auctions();
  final fetchInfo _fetchInfo = fetchInfo();
  //final GetDiscountedProducts discountedProducts = GetDiscountedProducts();
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
    await vendorProducts.getVendorProducts(widget.email);
    //await auctions.getVendorAuctions(fetchInfo.venEmail);
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Vendor Products',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(width: 1),
              ),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //images and facurite icon
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
                      child:SizedBox(
                        height: 30,
                        child: ElevatedButton(
                          onPressed: () async{
                            // Add your login logic here
                            GetSpecificPro gP= GetSpecificPro();
                            String ID = GetFeaturedProducts.featuredProd[index].productID.toString();
                            await gP.specificProducts(ID);
                            if(GetFeaturedProducts.featuredProd[index].stockQuantity!=0) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                  AddToCartScreen(productId: ID,)));
                            }
                            else{
                              FlutterToast.showToast("Sorry! this item is not available");
                            }
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
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
          );
        },
      )
          :
      const Center(child: Center(child:
      CircularProgressIndicator(color: Colors.red,),),),
    );
  }
}


