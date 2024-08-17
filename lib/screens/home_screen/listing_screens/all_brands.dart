import 'package:flutter/material.dart';

class AllBrands extends StatefulWidget {
  const AllBrands({Key? key}) : super(key: key);

  @override
  State<AllBrands> createState() => _AllBrandsState();
}

class _AllBrandsState extends State<AllBrands> {
  final item = [
    "assets/images/featured_images/shirt.png",
    "assets/images/featured_images/shirt1.jpeg",
    "assets/images/featured_images/shirt.png",
    "assets/images/featured_images/shirt1.jpeg",
    "assets/images/featured_images/shirt.png",
    "assets/images/featured_images/shirt1.jpeg",
    "assets/images/featured_images/shirt.png",
    "assets/images/featured_images/shirt1.jpeg",
    "assets/images/featured_images/shirt1.jpeg",
  ];
  final itemName = [
    'Lotuis Pholilppe blue',
    'Men blue',
    'Lotuis Pholilppe blue',
    'Men blue',
    'Lotuis Pholilppe blue',
    'Men blue',
    'Lotuis Pholilppe blue',
    'Men blue',
    'Lotuis Pholilppe blue',
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
          'Brands',
          style: TextStyle(
            //color: Colors.white,
              fontSize: 24,
              color: Colors.black
          ),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        //physics: AlwaysScrollableScrollPhysics(),
        //scrollDirection: Axis.vertical,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: item.length,
        itemBuilder: (BuildContext context, int index) {
          return  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              //height: 600,//MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                //color: Colors.yellow[200],
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(width: 1),
              ),
              child:  Container(
                //height: 180,width: 120,
                decoration: BoxDecoration(
                  color: color[index],
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage('assets/images/login_images/icons8-google-48.png'),),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  Widget buildCategoryCard(String image,String name) {
    return Container(
      height: 400,//MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.yellow[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child:  Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //images and facurite icon
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Align(alignment: Alignment.topRight,child: Icon(Icons.favorite_border)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
            child: Text(name),
          ),
          //Rating
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),//all(8.0),
            child: Row(
              children: [
                Icon(Icons.star_border),
                SizedBox(width: 2,),
                Text('0.0'),
              ],
            ),
          ),
          //Payment
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
            child: Row(
              children: [
                Text("120.00\$"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
