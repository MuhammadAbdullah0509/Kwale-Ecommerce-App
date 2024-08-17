// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../models/product_model/AllProducts.dart';
import '../../widgets_screens/flutter_toast.dart';
import '../../widgets_screens/http_link.dart';
import '../categories_screen/view_categories_products.dart';
import 'package:http/http.dart' as http;


class CategorySlider extends StatefulWidget {
  const CategorySlider({Key? key}) : super(key: key);

  @override
  State<CategorySlider> createState() => _CategorySliderState();
}

class _CategorySliderState extends State<CategorySlider> {
  final GetAllProducts getAllProducts = GetAllProducts();
  final item = [
    'assets/images/category_images/menAsset 2@4x-8.png',
    'assets/images/category_images/womenAsset 3@4x-8.png',
    'assets/images/category_images/kidsAsset 2@4x-8.png',
    'assets/images/category_images/accessAsset 1@4x-8.png',
    'assets/images/category_images/beautyAsset 1@4x-8.png',
  ];
  final itemName = [ 'Men',
    'Women',
    'Kids',
    'Home Accessories',
    'Beauty',];
  final color = const [
    Color(0xffFFF8DC),
    Color(0xffF0FFF0),
    Color(0xffF5F5DC),
    Color(0xffDBF9DB),
    Color(0xffF0FFF0),
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 140,
        child: ListView.builder(
          physics: const  AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: item.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () async{
                      print(itemName[index]);
                     await getAllProducts.getCategoryProducts(itemName[index]);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ViewProductByCategory(
                        category: itemName[index].toString(),
                      ),),);
                    },
                    child: Container(
                      width: 120,height: 120,
                      decoration: BoxDecoration(
                        color: color[index],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 1)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center ,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Image(
                              image: AssetImage(item[index]),),
                          ),
                          const SizedBox(height: 10,),
                          Text(itemName[index],style: const TextStyle(color: Colors.black,),textAlign: TextAlign.center,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
