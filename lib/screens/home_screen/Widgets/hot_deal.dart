// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kwale/models/product_model/DiscountedProducts.dart';
import 'package:kwale/screens/widgets_screens/http_link.dart';
import 'package:kwale/screens/widgets_screens/rating_bar.dart';

import '../../../models/product_model/GetSpecificProduct.dart';
import '../add_to_cart/add_to_cart.dart';

class HotDeals extends StatefulWidget {
  const HotDeals({Key? key}) : super(key: key);

  @override
  State<HotDeals> createState() => _HotDealsState();
}

class _HotDealsState extends State<HotDeals> {

  GetDiscountedProducts discountedProducts = GetDiscountedProducts();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    discountedProducts.getAllDisProducts();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/2,
      decoration: const BoxDecoration(
        //color: Colors.red,
        //borderRadius: BorderRadius.circular(12),
        //shape: BoxShape.rectangle,
      ),
      child:GetDiscountedProducts.discountedProd.length!=null?
      ListView.builder(
        physics: const  AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: GetDiscountedProducts.discountedProd.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async{
                    GetSpecificPro gP = GetSpecificPro();
                    String? pro_id = GetDiscountedProducts.discountedProd[index].productID;//(index + 1).toString();
                    await gP.specificProducts(GetDiscountedProducts.discountedProd[index].productID);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddToCartScreen(productId: pro_id,),
                      ),
                    );
                  },
                  child: Container(
                    width: 150,
                    //height: 100,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 0.1)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //images and facurite icon
                        Stack(
                          children: [
                            GetDiscountedProducts.discountedProd[index].productImage!=null?
                            Container(
                              height: 260,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: NetworkImage("${APILink.imageLink}${GetDiscountedProducts.discountedProd[index].productImage}"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                                :
                            const Center(child: Text("No Image"),),

                            // const Padding(
                            //   padding: EdgeInsets.all(8.0),
                            //   child: Align(alignment: Alignment.topRight,child: Icon(Icons.favorite_border)),
                            // ),
                          ],
                        ),
                        //const SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
                          child: Text(GetDiscountedProducts.discountedProd[index].name!=null?
                              GetDiscountedProducts.discountedProd[index].name.toString():"",
                          ),
                        ),
                        //const SizedBox(height: 10,),
                        //Rating
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),//all(8.0),
                          child: Row(
                            children: [
                              AddRatingBar(
                                  rating: double.parse(GetDiscountedProducts.discountedProd[index].productRating.toString())
                              )
                            ],
                          ),
                        ),
                        //const SizedBox(height: 10,),
                        //Payment
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                          child: Row(
                            children: [
                              Text(GetDiscountedProducts.discountedProd[index].discountAmount!=null?
                                  "price: ${GetDiscountedProducts.discountedProd[index].discountAmount.toString()} \$":
                              "price: ${GetDiscountedProducts.discountedProd[index].price!=null?
                              GetDiscountedProducts.discountedProd[index].discountAmount:""}"
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      )
          :
      const Center(child: Text("No Item"),),
    );
  }
}
