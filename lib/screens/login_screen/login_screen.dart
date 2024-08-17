// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kwale/screens/home_screen/home_screen.dart';
import 'package:kwale/screens/login_screen/forgot_password.dart';
import 'package:kwale/screens/signup_screen/signup_screen.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:kwale/screens/widgets_screens/flutter_toast.dart';
import 'package:kwale/screens/widgets_screens/google_signin.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/product_model/AllProducts.dart';
import '../../models/product_model/DiscountedProducts.dart';
import '../../models/product_model/GetAllFeaturedProducts.dart';
import '../../models/vendorModels/VendorProducts.dart';
import '../widgets_screens/http_link.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key,});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GetAllProducts _products = GetAllProducts();
  final GetFeaturedProducts fP = GetFeaturedProducts();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //final GoogleSignIn _googleSignIn = GoogleSignIn();
  final bool _obscurePassword = true;
  final bool _isLoggingIn = false;
  final AllVendorProducts vendorProducts = AllVendorProducts();
  final GetDiscountedProducts discountedProducts = GetDiscountedProducts();
  late String? username;
  late String? tokken;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }
  load() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString("username");
    tokken = prefs.getString("password");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(color: Colors.black,),);
          }
          else if(snapshot.hasData) {
            APILink.googleEmail = snapshot.data?.email;
            //APILink.googlePhoneNO = snapshot.data?.phoneNumber??'phone no';
            APILink.googleName = snapshot.data?.displayName??"Name";
            APILink.googleImage = snapshot.data?.photoURL.toString()??"image";
            //googleSignInAPI(snapshot.data!.email.toString());
            googleLogin(APILink.googleEmail);
            return  HomeScreen(
              email: snapshot.data?.email.toString(),
              userName: snapshot.data?.displayName.toString(),
              refresh: 1,
            );
          }
          else if(snapshot.hasError){
            return const Center(child: Text('Something wend wrong'));
          }
          else {
            APILink.googleEmail = null;
            APILink.googlePhoneNO = null;
            APILink.googleName = null;
            return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                const SizedBox(
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 54,
                      backgroundImage: AssetImage('assets/images/logo/Kwale-logo.png'),
                    ),
                  ),
                ),
                //Welcome Text
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                  child: Row(
                    children: [
                      Text(
                        'Welcome',
                        style: TextStyle(
                          //color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Text(
                        'Please login to your account',
                        style: TextStyle(
                          //color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                       Container(
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(12),
                           color: const Color(0xffF8F8FF),
                         ),
                         child: TextFormField(
                           controller: _emailController,
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: const TextStyle(color: Colors.black),
                            //prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                      ),
                       ),
                      const SizedBox(height: 20),
                      //password Text field
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xffF8F8FF),
                        ),
                        child: TextFormField(
                          controller: _passwordController,
                          cursorColor: Colors.black,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Add your forgot password logic here
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordScreen(),),);
                            },
                            child: const Text('Forgot password?', style: TextStyle(color: Colors.red),),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            // Add your login logic here
                            loginUser();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                              backgroundColor: Colors.red,
                          ),
                          child: _isLoggingIn
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text('Login'),
                        ),
                      ),
                      const SizedBox(height: 10),
                      //Google and Facebook Button
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Perform login with Google
                            final provider =
                            Provider.of<GoogleSingInProvider>(context,listen: false);
                            provider.googleLogin();
                          },
                          icon: Image.asset(
                            'assets/images/login_images/icons8-google-48.png',
                            height: 28,
                            width: 28,
                          ),
                          label: const Text('Google'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      //Skip and Continue (Navigate to home screen)

                      // TextButton(
                      //   onPressed: () {
                      //     // Add your forgot password logic here
                      //     Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),),);
                      //   },
                      //   style: TextButton.styleFrom(
                      //   ),
                      //   child: const Text('Skip & Continue', style: TextStyle(color: Colors.red),),
                      // ),
                     // const SizedBox(height: 8),
                      //Signup
                      TextButton(
                        onPressed: () {
                          // Add your forgot password logic here
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupScreen(),),);
                        },
                        child: const Text("Don't have an account? Signup", style: TextStyle(color: Colors.red),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
          }
        }
      ),
    );
  }
  Future<void> _saveLoginInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _emailController.text);
    await prefs.setString('password', _passwordController.text);
  }
  Future<void> loginUser() async{

    if(_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty)
    {
      var user = await http.post(Uri.parse('${APILink.link}Registration/loginUser'),
        body: ({
          "email": _emailController.text,
          "password":_passwordController.text,
        }),
      );
      if(user.statusCode == 200){
          await _products.getAllProducts();
          await _saveLoginInfo();
          APILink.defaultEmail = _emailController.text;
          APILink.vendorEmail = _emailController.text;
          await discountedProducts.getAllDisProducts();
          await fP.featuredProducts(APILink.defaultEmail.toString());
          FlutterToast.showToast('Your have been login Successfully!');
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
               HomeScreen(email: _emailController.text.toString(),refresh: 1,),),);
      }
      else if(user.statusCode == 404){
        FlutterToast.showToast('Invalid Credentials or You dont have account');
      }
      else {
        FlutterToast.showToast('Server Error! Please try again Thanks.');
      }
    }
    else {
      FlutterToast.showToast('Please fill all the fields!');
    }
  }
  googleLogin(googleEmail) async{
    await _products.getAllProducts();
    await fP.featuredProducts(googleEmail.toString());
    await discountedProducts.getAllDisProducts();
  }
}
