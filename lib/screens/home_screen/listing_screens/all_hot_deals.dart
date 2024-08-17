// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kwale/models/product_model/DiscountedProducts.dart';
import 'package:kwale/screens/widgets_screens/rating_bar.dart';

import '../../../models/product_model/GetSpecificProduct.dart';
import '../../widgets_screens/flutter_toast.dart';
import '../../widgets_screens/http_link.dart';
import '../add_to_cart/add_to_cart.dart';

class AllHotDeals extends StatefulWidget {
  const AllHotDeals({Key? key}) : super(key: key);

  @override
  State<AllHotDeals> createState() => _AllHotDealsState();
}

class _AllHotDealsState extends State<AllHotDeals> {
  final GetDiscountedProducts discountedProducts = GetDiscountedProducts();
  final item = [
    "assets/images/featured_images/shirt.png",
    "assets/images/featured_images/shirt1.jpeg",
    "assets/images/featured_images/shirt.png",
    "assets/images/featured_images/shirt1.jpeg",
    "assets/images/featured_images/shirt.png",
    "assets/images/featured_images/shirt1.jpeg",
    "assets/images/featured_images/shirt.png",
    "assets/images/featured_images/shirt1.jpeg",
  ];
  final itemName = [
    'Lotuis Pholilppe blue',
    'Men blue',
    'Lotuis Pholilppe blue',
    'Men blue',
    'Lotuis Pholilppe blue',
    'Men blue',
    'Lotuis Pholilppe blue',
    'Men blue',
  ];

  load() async {
    await discountedProducts.getAllDisProducts();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }
  @override
  Widget build(BuildContext context) {
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
        title: const Text(
          'Hot Deals',
          style: TextStyle(
            //color: Colors.white,
              fontSize: 24,
              color: Colors.black
          ),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        //physics: AlwaysScrollableScrollPhysics(),
        //scrollDirection: Axis.vertical,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 1.0),
        ),
        itemCount: GetDiscountedProducts.discountedProd.length,
        itemBuilder: (BuildContext context, int index) {
          return  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              //height: 600,//MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                //color: Colors.yellow[200],
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(width: 1),
              ),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //images and facurite icon
                  Expanded(
                    child: Stack(
                      children: [
                        GetDiscountedProducts.discountedProd[index].productImage!=null?
                        Container(
                          height: MediaQuery.of(context).size.height*2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: NetworkImage("${APILink.imageLink}${GetDiscountedProducts.discountedProd[index].productImage}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                        :
                        const Center(child: Text("No Image")),
                        // const Padding(
                        //   padding: EdgeInsets.all(8.0),
                        //   child: Align(alignment: Alignment.topRight,child: Icon(Icons.favorite_border)),
                        // ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0,),
                    child: Text(GetDiscountedProducts.discountedProd[index].name!=null?
                    GetDiscountedProducts.discountedProd[index].name.toString()
                        :
                    "",),
                  ),
                  //Rating
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),//all(8.0),
                    child: Row(
                      children: [
                        AddRatingBar(
                            rating: double.parse(GetDiscountedProducts.discountedProd[index].productRating.toString())
                        ),
                      ],
                    ),
                  ),
                  //Payment
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
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

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        height: 30,
                        child: ElevatedButton(
                          onPressed: () async{
                            // Add your login logic here
                            GetSpecificPro gP= GetSpecificPro();
                            String ID = GetDiscountedProducts.discountedProd[index].productID.toString();
                            await gP.specificProducts(ID);
                            if(GetDiscountedProducts.discountedProd[index].stockQuantity!=0) {
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
                  const SizedBox(height: 2,),
                ],
              ),
            ),
          );
          //buildCategoryCard(item[index],itemName[index]);
        },
      ),
    );
  }
  Widget buildCategoryCard(String image,String name) {
    return Container(
      height: 400,//MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.yellow[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child:  Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //images and facurite icon
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Align(alignment: Alignment.topRight,child: Icon(Icons.favorite_border)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
            child: Text(name),
          ),
          //Rating
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),//all(8.0),
            child: Row(
              children: [
                Icon(Icons.star_border),
                SizedBox(width: 2,),
                Text('0.0'),
              ],
            ),
          ),
          //Payment
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
            child: Row(
              children: [
                Text("120.00\$"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
