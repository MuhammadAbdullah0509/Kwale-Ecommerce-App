import 'package:flutter/material.dart';

class VendorScreen extends StatefulWidget {
  const VendorScreen({Key? key,}) : super(key: key);

  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  final item = [
    'assets/images/login_images/icons8-google-48.png',
    'assets/images/login_images/icons8-google-48.png',
    'assets/images/login_images/icons8-google-48.png',
    'assets/images/login_images/icons8-google-48.png',
    'assets/images/login_images/icons8-google-48.png',
    'assets/images/login_images/icons8-google-48.png',
    'assets/images/login_images/icons8-google-48.png',
    'assets/images/login_images/icons8-google-48.png',
    'assets/images/login_images/icons8-google-48.png',
  ];
  final itemName = [
    'Jerry Jerry',
    'Test',
    'Kayle',
    'Jerry Jerry',
    'Test',
    'Kayle',
    'Jerry Jerry',
    'Test',
    'Kayle',
  ];
  final color = const [
    Color(0xffFFF8DC),
    Color(0xffF0FFF0),
    Color(0xffDBF9DB),
    Color(0xffF5F5DC),
    Color(0xffF0FFF0),
    Color(0xffFFF8DC),
    Color(0xffDBF9DB),
    Color(0xffF0FFF0),
    Color(0xffF5F5DC),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListView.builder(
        physics: const  AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: item.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: 120,height: 120,
                  decoration: BoxDecoration(
                    color: color[index],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center ,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Image(
                          image: AssetImage(item[index]),),
                      ),
                      const SizedBox(height: 10,),
                      Text(itemName[index],style: const TextStyle(color: Colors.black),),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
