import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kwale/screens/widgets_screens/flutter_toast.dart';
import 'package:kwale/screens/widgets_screens/http_link.dart';
class AllProducts {
  AllProducts({
    this.productID,
    this.email,
    this.name,
    this.description,
    this.price,
    this.category,
    this.productImage,
    this.stockQuantity,
    this.rating,
    this.small,
    this.medium,
    this.large,
    this.xLarge,
    this.discountCode,
    this.discountAmount,
  });

  AllProducts.fromJson(dynamic json) {
    productID = json['product_ID'];
    email = json['email'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    category = json['category'];
    productImage = json['product_image'];
    stockQuantity = json['stock_quantity'];
    rating = json['product_rating'];
    small = json['small'];
    medium = json['medium'];
    large = json['large'];
    xLarge = json['x_large'];
    discountCode = json['discount_code'];
    discountAmount = json['discount_amount'];
  }
  String? productID;
  String? email;
  String? name;
  String? description;
  int? price;
  String? category;
  String? productImage;
  int? stockQuantity;
  double? rating;
  bool? small;
  bool? medium;
  bool? large;
  bool? xLarge;
  String? discountCode;
  dynamic discountAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_ID'] = productID;
    map['email'] = email;
    map['name'] = name;
    map['description'] = description;
    map['price'] = price;
    map['category'] = category;
    map['product_image'] = productImage;
    map['stock_quantity'] = stockQuantity;
    map['product_rating'] = rating;
    map['small'] = small;
    map['medium'] = medium;
    map['large'] = large;
    map['x_large'] = xLarge;
    map['discount_code'] = discountCode;
    map['discount_amount'] = discountAmount;
    return map;
  }
}

class GetAllProducts{
  static List<AllProducts> prod = [];

  Future<void> getAllProducts() async
  {
    var response = await http.get(Uri.parse("${APILink.link}Product/GetAllNewProduct"),);
    if(response.statusCode == 200){
      if(response.body.isNotEmpty) {
        Iterable<dynamic> list = jsonDecode(response.body);
        prod = list.map((e) => AllProducts.fromJson(e)).toList();
      }
    }
  }

  //get Products by category
  static List<AllProducts> categoryProd = [];

  Future<void> getCategoryProducts(cate) async
  {
    print(cate);
    categoryProd = [];
   try{
     var response = await http.get(Uri.parse("${APILink.link}Product/GetProductByCategory?cat=${cate}"),);
    if(response.statusCode == 200){
      if(response.body.isNotEmpty){
      Iterable<dynamic> list = jsonDecode(response.body);
      categoryProd = list.map((e) => AllProducts.fromJson(e)).toList();}
      print("${response.body}");
    }
    else if(response.statusCode == 302){
      FlutterToast.showToast("No Product is available");
    }
    else {
      FlutterToast.showToast("Something went wrong to the server");
    }
  }catch(exception) {
     throw exception;
   }
  }

  Future<void> updateProductRating(id,rating) async
  {
    var response = await http.post(Uri.parse("${APILink.link}Product/Update_rating"),
        body: ({
          "product_ID": id.toString(),
          "product_rating":rating.toString(),
        })
    );
    if(response.statusCode == 200){
      FlutterToast.showToast("Product is Updated successfully.");
    }
    else if(response.statusCode == 302) {
      FlutterToast.showToast("Product is updated successfully.");
    }
    else {
      FlutterToast.showToast("Something went wrong with server.");
    }
  }
}
