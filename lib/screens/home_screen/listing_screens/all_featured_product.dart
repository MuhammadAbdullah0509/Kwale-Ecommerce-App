// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:kwale/models/product_model/GetAllFeaturedProducts.dart';
import 'package:kwale/models/product_model/GetSpecificProduct.dart';
import 'package:kwale/screens/home_screen/add_to_cart/add_to_cart.dart';
import 'package:kwale/screens/widgets_screens/flutter_toast.dart';
import 'package:kwale/screens/widgets_screens/rating_bar.dart';
import 'package:kwale/screens/widgets_screens/refreshIndicator.dart';

import '../../widgets_screens/bottom_nav_bar.dart';
import '../../widgets_screens/http_link.dart';

class AllFeaturedProducts extends StatefulWidget {
  const AllFeaturedProducts({Key? key}) : super(key: key);

  @override
  State<AllFeaturedProducts> createState() => _AllFeaturedProductsState();
}

class _AllFeaturedProductsState extends State<AllFeaturedProducts> {
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
  bool favorite = true;
  final GetFeaturedProducts fP = GetFeaturedProducts();
  int _currentIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }
  Future<void> _refresh() async {
    // Perform your refresh logic here
    await Future.delayed(const Duration(seconds: 15));
    setState(() {});// Simulating a delay
  }

  void load()async{
    //await fP.featuredProducts('abc@123');
    setState(() {});
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
          'Featured products',
          style: TextStyle(
              color: Colors.black
          ),
        ),
        centerTitle: true,
      ),
      body: CustomRefreshIndicator(
        onRefresh: _refresh,
        child: GridView.builder(
           //physics: AlwaysScrollableScrollPhysics(),
           //scrollDirection: Axis.vertical,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1.0),
          ),
          itemCount: GetFeaturedProducts.featuredProd.length,
          itemBuilder: (BuildContext context, int index) {
            return  Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                //onTap: (){},
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
                            Container(
                              height: MediaQuery.of(context).size.height*2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: GetFeaturedProducts.featuredProd[index].productImage!=null? DecorationImage(
                                  image: NetworkImage("${APILink.imageLink}${GetFeaturedProducts.featuredProd[index].productImage}"),
                                  fit: BoxFit.cover,
                                )
                                    :
                                DecorationImage(
                                  image: AssetImage(item[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    onPressed: () async {
                                      await fP.addOrRemoveFeatured(
                                        GetFeaturedProducts.featuredProd[index].email.toString(),
                                        GetFeaturedProducts.featuredProd[index].productID.toString(),
                                        GetFeaturedProducts.featuredProd[index].name.toString(),
                                        GetFeaturedProducts.featuredProd[index].description.toString(),
                                        GetFeaturedProducts.featuredProd[index].price.toString(),
                                        GetFeaturedProducts.featuredProd[index].stockQuantity.toString(),
                                        GetFeaturedProducts.featuredProd[index].category.toString(),
                                        GetFeaturedProducts.featuredProd[index].productImage.toString(),
                                        GetFeaturedProducts.featuredProd[index].productRating.toString(),
                                      );
                                      await fP.featuredProducts(APILink.defaultEmail.toString());
                                      setState(() {});
                                    },
                                      icon: Icon(Icons.favorite_border,
                                        color: GetFeaturedProducts.featuredProd[index].isFavorite == true? Colors.red
                                        :
                                            Colors.white
                                        ,),),),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0,),
                        child: Text(GetFeaturedProducts.featuredProd[index].name!=null?
                        GetFeaturedProducts.featuredProd[index].name.toString()
                            :
                        "Product with no Name"
                          ,),
                      ),
                      //Rating
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),//all(8.0),
                        child: Row(
                          children: [
                           // Icon(Icons.star_border),
                            AddRatingBar(
                              rating: GetFeaturedProducts.featuredProd[index].productRating.toString()!=null?
                            double.parse(GetFeaturedProducts.featuredProd[index].productRating.toString()):1.0,),
                            // const SizedBox(width: 4,),
                            // Text(GetFeaturedProducts.featuredProd[index].productRating!=null?
                            // GetFeaturedProducts.featuredProd[index].productRating.toString()
                            //     :
                            // "0.0"),
                            //const Spacer(),
                          ],
                        ),
                      ),
                      //Payment
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Text(GetFeaturedProducts.featuredProd[index].price!=null?
                            "${GetFeaturedProducts.featuredProd[index].price.toString()} \$"
                                :
                            "0.0"
                              ,),
                            const Spacer(),
                            Text(GetFeaturedProducts.featuredProd[index].stockQuantity!=null
                              && GetFeaturedProducts.featuredProd[index].stockQuantity!=0
                              ?
                            "Available"
                                :
                            "Not Available"
                              ,),
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
                      //const SizedBox(height: 2,),
                    ],
                  ),
                ),
              ),
            );
            //buildCategoryCard(item[index],itemName[index]);
          },
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            },
          );
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
