import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:kwale/models/user_model/UserInfoModel.dart';
import 'package:kwale/models/vendorModels/GetSpecificVendor.dart';
import 'package:kwale/screens/widgets_screens/flutter_toast.dart';

import '../../screens/widgets_screens/http_link.dart';
class VendorProducts {
  VendorProducts({
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

  VendorProducts.fromJson(dynamic json) {
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

class AllVendorProducts
{
  GetVendor getVendor = GetVendor();
  static List<VendorProducts> vendorProducts = [];
  Future<void> getVendorProducts(email) async
  {
    var response = await http.get(Uri.parse("${APILink.link}Vendor/GetAllUploadedProducts?email=${email.toString()}"),);
    if(response.statusCode == 200)
    {
      if(response.body.isNotEmpty){
      Iterable<dynamic> list = jsonDecode(response.body);
      vendorProducts = list.map((e) => VendorProducts.fromJson(e)).toList();
      print(list);
      getVendor.getSpecificVendor(email.toString());
      }
    }
    else {
      print(response.statusCode);
      FlutterToast.showToast("Something went wrong with the server");
    }
  }

  Future<void> addProduct(email,name,des,price,stock,category,s,m,l,xl,image,image1,image2) async
  {
    var response = await http.post(Uri.parse("${APILink.link}Product/AddProduct"),
        body: ({
          "email": email.toString(),
          "name": name.toString(),
          "description":des.toString(),
          "price":price.toString(),
          "stock_quantity":stock.toString(),
          "category":category.toString(),
          "product_rating": "0.0",
          "small": s.toString(),
          "medium": m.toString(),
          "large": l.toString(),
          "x_large": xl.toString(),
        })
    );
    if(response.statusCode == 200){
      var res = await jsonDecode(response.body);
      await addProductImage(email, name, image);
      await addDetailedImages(res,image,image1,image2);
      FlutterToast.showToast("Product is Added successfully.");
    }
    else if(response.statusCode == 302) {
      FlutterToast.showToast("Product is updated successfully.");
    }
    else {
      FlutterToast.showToast("Something went wrong with server.");
    }
  }

  Future<void> addProductImage(email,name,image) async
  {
    var url = Uri.parse("${APILink.link}Product/Product_Image?email=${email.toString()}&name=${name.toString()}");
    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('photo', image));
    var response = await request.send();
    if (response.statusCode == 200) {
      // Image uploaded successfully
      print('Image uploaded successfully');
    } else {
      // Handle the error
      print('Failed to upload image. Status code: ${response.statusCode}');
    }
  }

  Future<void> addDetailedImages(id,image1,image2,image3) async
  {
    var url = Uri.parse("${APILink.link}Product/Add_Detailed_Product_Image?id=${id.toString()}");
    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('photo', image1,));
    request.files.add(await http.MultipartFile.fromPath('photo1', image2,));
    request.files.add(await http.MultipartFile.fromPath('photo2', image3,));
    var response = await request.send();
    if (response.statusCode == 200) {
      // Image uploaded successfully
      print("RES${response.statusCode}");
      print('Image uploaded successfully');
    } else {
      // Handle the error
      print('Failed to upload image. Status code: ${response.statusCode}');
    }
  }

  Future<void> updateProduct(id,price,stock,) async
  {
    var response = await http.post(Uri.parse("${APILink.link}Product/UpdateProducts"),
        body: ({
          "product_ID": id.toString(),
          "price":price.toString(),
          "stock_quantity":stock.toString(),
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

  Future<void> deleteProduct(id,price,stock,) async
  {
    var response = await http.post(Uri.parse("${APILink.link}Product/deleteProducts"),
        body: ({
          "product_ID": id.toString(),
        })
    );
    if(response.statusCode == 200){
      FlutterToast.showToast("Product is Deleted successfully.");
    }
    else {
      FlutterToast.showToast("Something went wrong with server.");
    }
  }
}