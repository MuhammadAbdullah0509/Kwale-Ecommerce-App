// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:kwale/models/product_model/GetSpecificProduct.dart';
import 'package:kwale/screens/widgets_screens/rating_bar.dart';
import '../../../models/product_model/AllProducts.dart';
import '../../widgets_screens/http_link.dart';
import '../add_to_cart/add_to_cart.dart';

class NewArrival extends StatefulWidget {
  const NewArrival({Key? key}) : super(key: key);

  @override
  State<NewArrival> createState() => _NewArrivalState();
}

class _NewArrivalState extends State<NewArrival> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
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
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: GetAllProducts.prod.length < 10
            ? GetAllProducts.prod.length
            : 10, //item.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    GetSpecificPro gP = GetSpecificPro();
                    //GetFeaturedProducts fP = GetFeaturedProducts();
                    String? proId = GetAllProducts.prod[index].productID
                        .toString(); //(index + 1).toString();
                    await gP.specificProducts(proId);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddToCartScreen(
                          productId: proId,
                        ),
                      ),
                    ).then((value) {
                      setState(() {});
                    });
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
                        //images and favorite icon
                        Stack(
                          children: [
                            Container(
                              height: 260,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "${APILink.imageLink}${GetAllProducts.prod[index].productImage}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        //Rating
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,vertical: 8), //all(8.0),
                          child: Row(
                            children: [
                              // const Icon(Icons.star_border),
                              AddRatingBar(
                                  rating:
                                  GetAllProducts.prod[index].rating != null
                                      ? double.parse(GetAllProducts
                                      .prod[index].rating
                                      .toString())
                                      : 0.0),
                            ],
                          ),
                        ),
                        //product Name
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4),
                          child: Text(
                            GetAllProducts.prod[index].name.toString()
                          ),
                        ),
                        //Payment
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4),
                          child: Row(
                            children: [
                              Text(
                                "${GetAllProducts.prod[index].price.toString()}\$",style: const TextStyle(color: Colors.red),
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
