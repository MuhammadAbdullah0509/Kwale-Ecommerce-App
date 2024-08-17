// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import '../../../models/product_model/GetAllFeaturedProducts.dart';
import '../../../models/product_model/GetSpecificProduct.dart';
import '../../widgets_screens/http_link.dart';
import '../../widgets_screens/rating_bar.dart';
import '../add_to_cart/add_to_cart.dart';

class FeaturedProducts extends StatefulWidget {
  const FeaturedProducts({Key? key}) : super(key: key);

  @override
  State<FeaturedProducts> createState() => _FeaturedProductsState();
}

class _FeaturedProductsState extends State<FeaturedProducts> {

  final GetFeaturedProducts fP = GetFeaturedProducts();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/2,
      decoration: const BoxDecoration(
      ),
      child: ListView.builder(
        physics: const  AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: GetFeaturedProducts.featuredProd.length<=10
            ? GetFeaturedProducts.featuredProd.length
            : 10,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    GetSpecificPro gP = GetSpecificPro();
                    String? pro_id = GetFeaturedProducts.featuredProd[index].productID.toString();//(index + 1).toString();
                    await gP.specificProducts(pro_id);
                    //await fP.getSpecificFeature(pro_id);
                    //print(pro_id);
                    //await gP.specificProducts(index);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddToCartScreen(productId: pro_id,),
                      ),
                    );
                    //print();
                  },
                  child: Container(
                    width: 150,
                    //height: 100,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 0.1)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 260,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "${APILink.imageLink}${GetFeaturedProducts.featuredProd[index].productImage}"),
                                  fit: BoxFit.cover,
                                )
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Align(
                            //     alignment: Alignment.topRight,
                            //     child: IconButton(
                            //       onPressed: () {
                            //         setState(() {
                            //           if(_iconColor !=Colors.red) {
                            //             _iconColor = Colors.red;
                            //           }else
                            //           _iconColor = Colors.white;
                            //         });
                            //       },
                            //       icon: Icon(Icons.favorite_border,color: _iconColor,),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        //const SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8.0),
                          child: Text(
                            GetFeaturedProducts.featuredProd[index].name != null
                                ? GetFeaturedProducts.featuredProd[index].name.toString()
                                : "Product with no Name",
                          ),
                        ),
                        //const SizedBox(height: 10,),
                        //Rating
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0), //all(8.0),
                          child: Row(
                            children: [
                              //const Icon(Icons.star_border),
                              AddRatingBar(rating:
                              GetFeaturedProducts.featuredProd[index].productRating != null
                                  ? double.parse(GetFeaturedProducts.featuredProd[index].productRating.toString())
                                  : 0.0
                              ),
                              // const SizedBox(
                              //   width: 2,
                              // ),
                              // Text(
                              //   GetFeaturedProducts.featuredProd[index].productRating != null
                              //       ? GetFeaturedProducts.featuredProd[index].productRating
                              //       .toString()
                              //       : "No Rating",
                              // ),
                            ],
                          ),
                        ),
                        //const SizedBox(height: 10,),
                        //Payment
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4),
                          child: Row(
                            children: [
                              Text(
                                GetFeaturedProducts.featuredProd[index].price != null
                                    ? GetFeaturedProducts.featuredProd[index].price
                                    .toString()
                                    : "No price",
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
      ),
    );
  }
}
