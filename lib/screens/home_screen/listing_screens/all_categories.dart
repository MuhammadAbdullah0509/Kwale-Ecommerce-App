// ignore_for_file: use_build_context_synchronously

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kwale/models/product_model/AllProducts.dart';
import 'package:kwale/screens/home_screen/categories_screen/view_categories_products.dart';

class AllCategories extends StatefulWidget {
  const AllCategories({Key? key}) : super(key: key);

  @override
  State<AllCategories> createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  final GetAllProducts getAllProducts = GetAllProducts();
  final item = [
    'assets/images/category_images/menAsset 2@4x-8.png',
    'assets/images/category_images/womenAsset 3@4x-8.png',
    'assets/images/category_images/kidsAsset 2@4x-8.png',
    'assets/images/category_images/accessAsset 1@4x-8.png',
    'assets/images/category_images/beautyAsset 1@4x-8.png',
  ];
  final itemName = [
    'Men',
    'Women',
    'Kids',
    'Home Accessories',
    'Beauty',
  ];
  final color = const [
    Color(0xffFFF8DC),
    Color(0xffF0FFF0),
    Color(0xffDBF9DB),
    Color(0xffFFF8DC),
    Color(0xffF0FFF0),
  ];
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
          'All Categories',
          style: TextStyle(
            //color: Colors.white,
              fontSize: 24,
              color: Colors.black
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          //  height: 200 ,
          child: ListView.builder(
            itemCount: item.length  ,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                  onTap: () async{
                    await getAllProducts.getCategoryProducts(itemName[index]);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewProductByCategory(
                      category: itemName[index].toString(),
                    ),),);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: color[index],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(width: 0.1)
                    ),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center ,
                      children: [
                        //const SizedBox(width: 5,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Image(
                              image: AssetImage(item[index]),
                              fit: BoxFit.fill ,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8,),
                        Expanded(child: Text(itemName[index],style: const TextStyle(color: Colors.black),)),
                        const Spacer(),
                        GestureDetector(
                          onTap: () async{
                            //Move To New Window
                          },
                            child: const Icon(Icons.arrow_forward_ios_outlined),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
