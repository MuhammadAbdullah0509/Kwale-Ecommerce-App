import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../screens/widgets_screens/flutter_toast.dart';
import '../../screens/widgets_screens/http_link.dart';
class DiscountedProducts {
  DiscountedProducts({
      this.productID, 
      this.email, 
      this.name, 
      this.description, 
      this.price, 
      this.stockQuantity, 
      this.category, 
      this.productImage, 
      this.productRating, 
      this.small, 
      this.medium, 
      this.large, 
      this.xLarge, 
      this.discountCode, 
      this.discountAmount,});

  DiscountedProducts.fromJson(dynamic json) {
    productID = json['product_ID'];
    email = json['email'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stockQuantity = json['stock_quantity'];
    category = json['category'];
    productImage = json['product_image'];
    productRating = json['product_rating'];
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
  int? stockQuantity;
  String? category;
  String? productImage;
  double? productRating;
  bool? small;
  bool? medium;
  bool? large;
  bool? xLarge;
  String? discountCode;
  int? discountAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_ID'] = productID;
    map['email'] = email;
    map['name'] = name;
    map['description'] = description;
    map['price'] = price;
    map['stock_quantity'] = stockQuantity;
    map['category'] = category;
    map['product_image'] = productImage;
    map['product_rating'] = productRating;
    map['small'] = small;
    map['medium'] = medium;
    map['large'] = large;
    map['x_large'] = xLarge;
    map['discount_code'] = discountCode;
    map['discount_amount'] = discountAmount;
    return map;
  }

}

class GetDiscountedProducts{
  static List<DiscountedProducts> discountedProd = [];

  Future<void> getAllDisProducts() async
  {
    var response = await http.get(Uri.parse("${APILink.link}Product/GetDiscountedProduct"),);
    if(response.statusCode == 200){
      if(response.body.isNotEmpty){
      Iterable<dynamic> list = jsonDecode(response.body);
      discountedProd = list.map((e) => DiscountedProducts.fromJson(e)).toList();
      //print("Name${discountedProd[0].name}");
      print(list);}
    }
  }

  Future<void> addDiscountOnProducts(id,disAmount) async
  {
    var response = await http.post(Uri.parse("${APILink.link}Product/AddDiscountOnProduct"),
        body: ({
          "product_ID": id.toString(),
          "discount_code": "kwale",
          "discount_amount": disAmount
        })
    );
    if(response.statusCode == 200)
    {
      FlutterToast.showToast("Discount added successfully");
    }
    else if(response.statusCode == 404)
    {
      FlutterToast.showToast("product not found");
    }
    else {
      FlutterToast.showToast("Something went wrong");
    }
  }

}