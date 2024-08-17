import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kwale/screens/home_screen/home_screen.dart';
import 'package:kwale/screens/login_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/product_model/AllProducts.dart';
import '../../models/product_model/DiscountedProducts.dart';
import '../../models/product_model/GetAllFeaturedProducts.dart';
import '../widgets_screens/http_link.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  final GetDiscountedProducts discountedProducts = GetDiscountedProducts();
  final GetAllProducts _products = GetAllProducts();
  final GetFeaturedProducts fP = GetFeaturedProducts();
  String? userName;
  String? password;
  @override
  void initState() {
    super.initState();

    load();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _fadeInAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward();

    Future.delayed(const Duration(seconds: 5), () {
      if(userName == null && password == null) {
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
      else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  load() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = await prefs.getString('username');
    password = await prefs.getString('password');
    print(userName);
    print(password);
    if(userName.toString().isNotEmpty){
      APILink.defaultEmail = userName;
      APILink.vendorEmail = userName;
      await _products.getAllProducts();
      await fP.featuredProducts(APILink.defaultEmail.toString());
      await discountedProducts.getAllDisProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body:AnimatedBuilder(
        animation: _fadeInAnimation,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeInAnimation.value,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo/Kwale-logo.png',),

                  ),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(height: 16),
                      SpinKitFadingCircle(
                        color: Colors.red,
                        size: 50.0,
                      ),
                      SizedBox(height: 16),
                      Center(
                          child: Text(
                            '@Kwale',
                            style: TextStyle(color: Colors.black),
                          ),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
