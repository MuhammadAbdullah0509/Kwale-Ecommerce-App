// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kwale/models/cart_model/AddToCart.dart';
import 'package:kwale/models/cart_model/PurchaseHistory.dart';
import 'package:kwale/screens/home_screen/add_to_cart/order_confirmed.dart';
import 'package:kwale/screens/widgets_screens/flutter_toast.dart';
import 'package:kwale/screens/widgets_screens/http_link.dart';

class PaymentScreen extends StatefulWidget {
  final dynamic? amount;
  final int? quantity;
  final String? id,vemail,image,name,address;
  const PaymentScreen({super.key, this.amount,this.id,this.quantity,this.vemail,this.image,this.name,this.address});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _paymentController = TextEditingController();
  final TextEditingController _cardController = TextEditingController();
  final TextEditingController _expiredController = TextEditingController();
  final TextEditingController _cVVController = TextEditingController();
  final Cart cart = Cart();
  final GetPurchases getPurchases = GetPurchases();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _paymentController.text = widget.amount.toString();
  }
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
        title: const Text('Payment Screen', style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 400,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/card_images/Card 1.png'), // Replace 'card_image.png' with your card image asset path
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xffF8F8FF),
                ),
                child: TextFormField(
                  controller: _paymentController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Total Amount',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xffF8F8FF),
                ),
                child: TextFormField(
                  controller: _cardController,
                  decoration: InputDecoration(
                    labelText: 'Card Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xffF8F8FF),
                ),
                child: TextFormField(
                  controller: _expiredController,
                  decoration: InputDecoration(
                    labelText: 'Expiration Date',
                    hintText: '12/5/2023',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xffF8F8FF),
                ),
                child: TextFormField(
                  controller: _cVVController,
                  //maxLength: 3,
                  decoration: InputDecoration(
                    labelText: 'CVV',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                height: 60,
                child: ElevatedButton(
                  onPressed: () async{
                    // Implement your payment processing logic here
                    await paymentClearance();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Make Payment'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> paymentClearance() async{
    if(_cardController.text.isNotEmpty && _expiredController.text.isNotEmpty && _cVVController.text.isNotEmpty){
      await cart.updateProductQuantity(widget.id, widget.quantity);
      await cart.updateDataOnSales(widget.vemail,_paymentController.text);
      await cart.removeCartItems(APILink.defaultEmail,widget.id);
      await getPurchases.addDataOnPurchase(
          widget.id,
          widget.vemail,
          APILink.defaultEmail,
          widget.name,
          widget.address,
          widget.image);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderConfirmed(),),);
    }
    else{
      FlutterToast.showToast('Please fill all the required fields');
    }
  }
}

