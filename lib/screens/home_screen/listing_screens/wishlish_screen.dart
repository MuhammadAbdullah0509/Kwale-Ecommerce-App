import 'package:flutter/material.dart';
import 'package:kwale/screens/widgets_screens/bottom_nav_bar.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  int _currentIndex = 0;
  final item = [
    "assets/images/featured_images/shirt.png",
    "assets/images/featured_images/shirt1.jpeg",
    "assets/images/featured_images/shirt.png",
    "assets/images/featured_images/shirt1.jpeg",
    "assets/images/featured_images/shirt.png",
    "assets/images/featured_images/shirt1.jpeg",
    "assets/images/featured_images/shirt.png",
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
          'Whishlist',
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
          crossAxisCount: 2,
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
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //images and facurite icon
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height*2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage(item[index]),
                              fit: BoxFit.cover,
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
                    padding: const EdgeInsets.symmetric(horizontal: 8.0,),
                    child: Text(itemName[index]),
                  ),
                  //Rating
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),//all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.star_border),
                        SizedBox(width: 4,),
                        Text('0.0'),
                      ],
                    ),
                  ),
                  //Payment
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        const Text("120.00\$"),
                        const Spacer(),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              item.length =item.length - 1;
                            });
                          },
                            child: const Icon(Icons.delete_outlined,color: Colors.red,)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2,),
                ],
              ),
            ),
          );
          //buildCategoryCard(item[index],itemName[index]);
        },
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
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
