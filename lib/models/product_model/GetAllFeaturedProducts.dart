import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kwale/screens/widgets_screens/flutter_toast.dart';

import '../../screens/widgets_screens/http_link.dart';
class GetAllFeaturedProducts {
  GetAllFeaturedProducts({
      this.productID, 
      this.email, 
      this.name, 
      this.description, 
      this.price, 
      this.stockQuantity, 
      this.category, 
      this.productImage, 
      this.productRating,
    this.isFavorite,
  });

  GetAllFeaturedProducts.fromJson(dynamic json) {
    productID = json['product_ID'];
    email = json['email'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stockQuantity = json['stock_quantity'];
    category = json['category'];
    productImage = json['product_image'];
    productRating = json['product_rating'];
    isFavorite = json['favorit'];
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
  bool? isFavorite;

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
    map['favorit'] = isFavorite;
    return map;
  }

}

class GetFeaturedProducts{
  static List<GetAllFeaturedProducts> featuredProd =[];
  Future<void> featuredProducts(String email) async
  {
    var response = await http.get(Uri.parse("${APILink.link}Product/GetAllFeaturedProduct?email=${email.toString()}"),);
    if(response.statusCode == 200){
      if(response.body.isNotEmpty) {
        Iterable<dynamic>list = jsonDecode(response.body);
        featuredProd =
            list.map((e) => GetAllFeaturedProducts.fromJson(e)).toList();
      }
      //featuredProd.add(GetAllFeaturedProducts.fromJson(list.toString()));
      //featuredProd.add(GetAllFeaturedProducts.fromJson(list));
      //specificProd = list.map((e) => GetSpecificProduct.fromJson(e)).toList();
    }
  }
  
  Future<void> addOrRemoveFeatured(email, id, name,des,price,stock,category,image,rating) async
  {
    var response = await http.post(Uri.parse("${APILink.link}Product/FeaturedProduct"),
      body: ({
        "email":email.toString(),
        "product_ID":id.toString(),
        "name": name.toString(),
        "description": des.toString(),
        "price": price,
        "stock_quantity": stock,
        "category": category,
        "product_image": image.toString(),
        "product_rating": rating,
        "favorit": true.toString()
      })
    );
    if(response.statusCode == 200)
    {
      FlutterToast.showToast("Mark as Favorite");
    }
    else if(response.statusCode == 302)
    {
      FlutterToast.showToast("Removed from Favorite");
    }
    else {
      FlutterToast.showToast("Something went wrong");
    }
  }

  static bool isFeaturedPro = false;
  Future<void> getSpecificFeature(email,id) async
  {
    var response = await http.get(Uri.parse("${APILink.link}Product/GetSpecificFeaturedProduct?email=${email.toString()}&"
        "id=${id.toString()}"),);
    if(response.statusCode == 200)
    {
      if(response.body.isNotEmpty){
      print("body${response.body}");
      isFeaturedPro = true;
      }
    }
    else if(response.statusCode == 404){
      isFeaturedPro = false;
    }
    else {

      throw Exception();
    }
  }
}
