import 'package:flutter/material.dart';
import 'package:kwale/screens/home_screen/home_screen.dart';

class OrderConfirmed extends StatefulWidget {
  const OrderConfirmed({super.key});

  @override
  State<OrderConfirmed> createState() => _OrderConfirmedState();
}

class _OrderConfirmedState extends State<OrderConfirmed> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      // After the splash screen duration, navigate to the main screen or any other screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          // image: DecorationImage(
          //     image: AssetImage('assets/images/order_confirmed/order_confirmed 1@1x.png'),
          // ),
        ),
        child: Column(
          children: [
            Image(
              image: const AssetImage('assets/images/order_confirmed/order_confirmed 1.png'),
              width: MediaQuery.of(context).size.width,
            ),
           // const SizedBox(height: 10,),
            const Text('Order Confirmed!',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28),),
            const SizedBox(height: 10,),
            const Expanded(
              //flex: 1,
              child: SizedBox(
                width: 300,
                child: Text('Your order has been confirmed, we will send you confirmation email shortly.',
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
                    return HomeScreen();
                  }), (r){
                    return false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Continue Shopping'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
