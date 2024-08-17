import 'package:flutter/material.dart';

class AllVendors extends StatefulWidget {
  const AllVendors({Key? key,}) : super(key: key);

  @override
  State<AllVendors> createState() => _AllVendorsState();
}

class _AllVendorsState extends State<AllVendors> {

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
        title: const Text(
          'All Vendors',
          style: TextStyle(
            //color: Colors.white,
              fontSize: 24,
              color: Colors.black
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          //width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemCount: item.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: color[index],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(width: 0.1)
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center ,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image(
                            image: AssetImage(item[index]),
                            fit: BoxFit.cover ,
                          ),
                        ),
                      ),
                      //const SizedBox(height: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(itemName[index],style: const TextStyle(color: Colors.black),),
                          const Row(
                            children: [
                              Icon(Icons.star_border),
                              SizedBox(width: 2,),
                              Text('0.0',style: TextStyle(color: Colors.black),),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: GestureDetector(
                          onTap: (){
                            //Move To New Window
                          },
                          child: const Icon(Icons.arrow_forward_ios_outlined),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
