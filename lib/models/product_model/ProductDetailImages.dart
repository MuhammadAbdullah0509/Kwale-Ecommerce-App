import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../../screens/widgets_screens/http_link.dart';
import 'dart:io';
class ProductDetailImages {
  ProductDetailImages({
      this.productID, 
      this.image1, 
      this.image3, 
      this.image2,});

  ProductDetailImages.fromJson(dynamic json) {
    productID = json['product_ID'];
    image1 = json['image1'];
    image3 = json['image3'];
    image2 = json['image2'];
  }
  String? productID;
  String? image1;
  String? image3;
  String? image2;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_ID'] = productID;
    map['image1'] = image1;
    map['image3'] = image3;
    map['image2'] = image2;
    return map;
  }

}

class GetProductDetailedImages{
  static List<ProductDetailImages> prodImages =[];
  static List<File> localImageFiles = [];
  Future<void> specificProductsImages(id) async
  {
    try {
      var response = await http.get(Uri.parse(
          "${APILink.link}Product/GetDetailProductImage?id=${id
              .toString()}"),);
      if (response.statusCode == 200) {
        if(response.body.isNotEmpty){
        Iterable<dynamic> list = jsonDecode(response.body);
        prodImages = list.map((e) => ProductDetailImages.fromJson(e)).toList();
        final appDir = await getTemporaryDirectory();
        print(prodImages[0].image1);
        print(prodImages[0].image2);
        print(prodImages[0].image3);
        //final localImage = File(prodImages[0].image1.toString());
        //await localImage.writeAsBytes(response.bodyBytes);
        //localImageFiles.add(localImage);
        //print("local${localImage}");
        }
      }
      print(response.statusCode);
    }catch(exception){
      throw exception;
    }
  }
}