import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kwale/models/product_model/ProductDetailImages.dart';

import '../../screens/widgets_screens/http_link.dart';
class GetSpecificProduct {
  GetSpecificProduct({
      this.productID, 
      this.email, 
      this.name, 
      this.description, 
      this.price, 
      this.category, 
      this.productImage, 
      this.stockQuantity, 
      this.productRating,
      this.small,
      this.medium,
      this.large,
      this.xLarge,
    this.discountCode,
    this.discountAmount,
  });

  GetSpecificProduct.fromJson(dynamic json) {
    productID = json['product_ID'];
    email = json['email'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    category = json['category'];
    productImage = json['product_image'];
    stockQuantity = json['stock_quantity'];
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
  String? category;
  String? productImage;
  int? stockQuantity;
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
    map['category'] = category;
    map['product_image'] = productImage;
    map['stock_quantity'] = stockQuantity;
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

class GetSpecificPro{
  GetProductDetailedImages detailedImages = GetProductDetailedImages();
  static List<GetSpecificProduct> specificProd =[];
  Future<void> specificProducts(id) async
  {
    try{
    specificProd = [];
    var response = await http.post(Uri.parse("${APILink.link}Product/GetSpecificProduct"),
        body: ({
          "product_ID":id.toString(),
        })
    );
    if(response.statusCode == 200){
      if(response.body.isNotEmpty) {
        var list = jsonDecode(response.body);
        specificProd.add(GetSpecificProduct.fromJson(list));
        print("name${specificProd[0].productImage}");
        await detailedImages.specificProductsImages(id);
      }
    }
    }catch(exception){
      print(exception);
      throw exception;
    }
  }
}
