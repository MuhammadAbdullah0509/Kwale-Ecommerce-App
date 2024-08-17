import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../screens/widgets_screens/flutter_toast.dart';
import '../../screens/widgets_screens/http_link.dart';
class PurchaseHistory {
  PurchaseHistory({
      this.purchaseId, 
      this.vemail, 
      this.uemail, 
      this.productID, 
      this.productName, 
      this.uaddress, 
      this.delivered,
    this.productImage
  });

  PurchaseHistory.fromJson(dynamic json) {
    purchaseId = json['purchase_id'];
    vemail = json['vemail'];
    uemail = json['uemail'];
    productID = json['product_ID'];
    productName = json['product_name'];
    uaddress = json['uaddress'];
    delivered = json['delivered'];
    productImage = json['product_image'];
  }
  int? purchaseId;
  String? vemail;
  String? uemail;
  String? productID;
  String? productName;
  String? uaddress;
  bool? delivered;
  String? productImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['purchase_id'] = purchaseId;
    map['vemail'] = vemail;
    map['uemail'] = uemail;
    map['product_ID'] = productID;
    map['product_name'] = productName;
    map['uaddress'] = uaddress;
    map['delivered'] = delivered;
    map['product_image'] = productImage;
    return map;
  }

}

class GetPurchases{

  static List<PurchaseHistory> purchaseItem = [];
  Future<void> getPurchaseItems(email) async
  {
    var response = await http.get(Uri.parse("${APILink.link}Product/GetPurchaseHistory?email=${email.toString()}"));
    if(response.statusCode == 200){
      Iterable<dynamic> list = jsonDecode(response.body);
      purchaseItem = list.map((e) => PurchaseHistory.fromJson(e)).toList();
      print(list);
    }
  }

  Future<void> addDataOnPurchase(id,vemail,uemail,name,address,image) async
  {
    var response = await http.post(Uri.parse("${APILink.link}Product/AddDataIntoPurchase"),
      body: ({
        "vemail": vemail.toString(),
        "uemail": uemail.toString(),
        "product_ID": id.toString(),
        "product_name": name.toString(),
        "uaddress": address.toString(),
        "delivered": false.toString(),
        "product_image": image.toString()
      }),);
    if(response.statusCode == 200)
    {
      print("successfully purchase");
      //FlutterToast.showToast('Payment Done');
    }
    else if(response.statusCode == 500)
    {
      FlutterToast.showToast('something went wrong to the server please try again');
    }
    else{
      print(response.statusCode);
    }
  }

  static List<PurchaseHistory> vendorSalesItem = [];
  Future<void> getVendorSalesItems(email) async
  {
    var response = await http.get(Uri.parse("${APILink.link}Product/GetVendorSalesHistory?email=${email.toString()}"));
    if(response.statusCode == 200){
      Iterable<dynamic> list = jsonDecode(response.body);
      vendorSalesItem = list.map((e) => PurchaseHistory.fromJson(e)).toList();
      print(list);
    }
  }
}