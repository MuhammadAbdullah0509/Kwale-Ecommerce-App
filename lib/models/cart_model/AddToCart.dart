import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kwale/screens/widgets_screens/flutter_toast.dart';
import 'package:kwale/screens/widgets_screens/http_link.dart';

class AddToCart {
  AddToCart({
      this.email, 
      this.productId, 
      this.productName, 
      this.productImage, 
      this.quantity, 
      this.totalAmount, 
      this.address,
    this.vemail
  });

  AddToCart.fromJson(dynamic json) {
    email = json['email'];
    productId = json['product_id'];
    productName = json['product_name'];
    productImage = json['product_image'];
    quantity = json['quantity'];
    totalAmount = json['total_amount'];
    address = json['address'];
    vemail = json['vemail'];
  }
  String? email;
  String? productId;
  String? productName;
  String? productImage;
  int? quantity;
  int? totalAmount;
  String? address;
  String? vemail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['product_id'] = productId;
    map['product_name'] = productName;
    map['product_image'] = productImage;
    map['quantity'] = quantity;
    map['total_amount'] = totalAmount;
    map['address'] = address;
    map['vemail'] = vemail;
    return map;
  }

}

class Cart {
  static List<AddToCart> cartItem = [];
  Future<void> getCartItems(email) async
  {
    var response = await http.get(Uri.parse("${APILink.link}Cart/GetAllCartItems.?email=${email.toString()}"));
    if(response.statusCode == 200){
      if(response.body.isNotEmpty) {
        Iterable<dynamic> list = jsonDecode(response.body);
        cartItem = list.map((e) => AddToCart.fromJson(e)).toList();
        print(list);
      }
    }
  }

  Future<void> addItemToCart(email,id,name,image,quantity,amount,address,vemail) async
  {
    var response = await http.post(Uri.parse("${APILink.link}Cart/AddToCart"),
    body: ({
      "email":email.toString(),
      "product_id":id.toString(),
      "product_name":name.toString(),
      "product_image":image.toString(),
      "quantity":quantity.toString(),
      "total_amount":amount.toString(),
      "address":address.toString(),
      "vemail": vemail.toString(),
    }));
    if(response.statusCode == 200)
    {
      FlutterToast.showToast('Item is successfully added to cart');
    }
    else if(response.statusCode == 500)
    {
      FlutterToast.showToast('something went wrong to the server please try again');
    }
  }

  Future<void> removeCartItems(email,id) async
  {
    var response = await http.post(Uri.parse("${APILink.link}Cart/RemoveCartItems.?email=${email.toString()}&id=${id.toString()}"));
    if(response.statusCode == 200){
      //FlutterToast.showToast("Successfully Deleted");
    }
    else if(response.statusCode == 500)
    {
      FlutterToast.showToast("Something went wrong");
    }
    else print(response.statusCode);
  }
  static String tAmount = '';
  Future<void> getTotalAmount(email) async
  {
    var response = await http.get(Uri.parse("${APILink.link}Cart/GetTotalAmount?email=${email.toString()}"));
    if(response.statusCode == 200){
      tAmount = response.body;
      print(tAmount.toString());
    }
    else if(response.statusCode == 500)
    {
      FlutterToast.showToast("Something went wrong");
    }
    else print(response.statusCode);
  }

  Future<void> updateProductQuantity(id,quantity) async
  {
    var response = await http.post(Uri.parse("${APILink.link}Product/UpdateQuantityOnSale"),
        body: ({
          "product_ID":id.toString(),
          "stock_quantity":quantity.toString()
        }),);
    if(response.statusCode == 200)
    {
      //FlutterToast.showToast('Payment Done');
    }
    else if(response.statusCode == 500)
    {
      FlutterToast.showToast('something went wrong to the server please try again');
    }
  }

  Future<void> updateDataOnSales(email,amount) async
  {
    DateTime dateTime = DateTime.now();
    int month = await dateTime.month;
    int year = await dateTime.year;
    var response = await http.post(Uri.parse("${APILink.link}Product/AddDataIntoSale"),
      body: ({
        "email": email,
        "date": dateTime.toString(),
        "monthly_sales": amount,
        "month": month.toString(),
        "year_sales": amount,
        "year": year.toString()
      }),);
    if(response.statusCode == 200)
    {
      FlutterToast.showToast('Payment Done');
    }
    else if(response.statusCode == 500)
    {
      FlutterToast.showToast('something went wrong to the server please try again');
    }
    else{
      print(response.statusCode);
    }
  }


}