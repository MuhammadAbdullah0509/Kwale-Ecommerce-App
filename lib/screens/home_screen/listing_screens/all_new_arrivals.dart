// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kwale/models/product_model/AllProducts.dart';
import 'package:kwale/screens/widgets_screens/refreshIndicator.dart';

import '../../../models/product_model/GetAllFeaturedProducts.dart';
import '../../../models/product_model/GetSpecificProduct.dart';
import '../../widgets_screens/flutter_toast.dart';
import '../../widgets_screens/http_link.dart';
import '../../widgets_screens/rating_bar.dart';
import '../add_to_cart/add_to_cart.dart';

class AllNewArrivals extends StatefulWidget {
  const AllNewArrivals({Key? key}) : super(key: key);

  @override
  State<AllNewArrivals> createState() => _AllNewArrivalsState();
}

class _AllNewArrivalsState extends State<AllNewArrivals> {
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

  Future<void> _refresh() async {
    // Perform your refresh logic here
    await Future.delayed(const Duration(seconds: 15)); // Simulating a delay
    print('Refreshed');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("${APILink.imageLink}${GetAllProducts.prod[0].productImage}");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
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
            'New Arrivals',
            style: TextStyle(
              //color: Colors.white,
                fontSize: 24,
                color: Colors.black
            ),
          ),
          centerTitle: true,
        ),
        body: CustomRefreshIndicator(
          onRefresh: _refresh,
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 1.1),
            ),
            itemCount: GetAllProducts.prod.length,//item.length,//replace with prod list length
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
                            Container(
                              height: MediaQuery.of(context).size.height*2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image:
                                GetAllProducts.prod[index].productImage!=null? DecorationImage(
                                  image: NetworkImage("${APILink.imageLink}${GetAllProducts.prod[index].productImage}"),
                                  fit: BoxFit.cover,
                                )
                                    :
                                DecorationImage(
                                  image: AssetImage(item[index]),
                                  fit: BoxFit.cover,
                                )
                                ,
                              ),
                            ),
                            // const Padding(
                            //   padding: EdgeInsets.all(8.0),
                            //   child: Align(alignment: Alignment.topRight,child: Icon(Icons.favorite_border)),
                            // ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0,),
                        child: Text(GetAllProducts.prod[index].name!=null?
                            GetAllProducts.prod[index].name.toString()
                            :
                            "Product with no Name"
                          ,),
                      ),
                      //Rating
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 6),//all(8.0),
                        child: Row(
                          children: [
                            AddRatingBar(
                              rating: GetAllProducts.prod[index].rating.toString()!=null?
                              double.parse(GetAllProducts.prod[index].rating.toString()):1.0,),
                            //const Spacer(),

                          ],
                        ),
                      ),
                      //Payment
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 3),
                        child: Row(
                          children: [
                            Text(GetAllProducts.prod[index].price.toString()),
                            const Spacer(),
                            Text(GetAllProducts.prod[index].stockQuantity!=null
                                && GetAllProducts.prod[index].stockQuantity!=0
                                ?
                            "Available"
                                :
                            "Not Available"
                              ,),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () async{
                                // Add your login logic here
                                GetSpecificPro gP= GetSpecificPro();
                                //GetFeaturedProducts fP = GetFeaturedProducts();
                                String ID = GetAllProducts.prod[index].productID.toString();
                                await gP.specificProducts(ID);
                                //await fP.getSpecificFeature(ID);
                                if(GetAllProducts.prod[index].stockQuantity!=0) {
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
                      const SizedBox(height: 4,),
                    ],
                  ),
                ),
              );
              //buildCategoryCard(item[index],itemName[index]);
            },
          ),
        ),
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
