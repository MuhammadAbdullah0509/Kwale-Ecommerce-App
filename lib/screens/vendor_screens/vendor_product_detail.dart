// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kwale/models/cart_model/AddToCart.dart';
import 'package:kwale/models/product_model/GetAllFeaturedProducts.dart';
import 'package:kwale/models/product_model/GetSpecificProduct.dart';
import 'package:kwale/models/vendorModels/GetSpecificVendor.dart';
import 'package:kwale/screens/widgets_screens/rating_bar.dart';
import '../../../models/chat_model/ChatModel.dart';
import '../../../models/product_model/ProductDetailImages.dart';
import '../../../models/vendorModels/AuctionModel.dart';
import '../../models/product_model/DiscountedProducts.dart';
import '../../models/vendorModels/VendorProducts.dart';
import '../widgets_screens/http_link.dart';

class VendorDetailProductScreen extends StatefulWidget {
  final String? productId;
  final String? val;
  const VendorDetailProductScreen({super.key, this.productId,this.val});

  @override
  VendorDetailProductScreenState createState() => VendorDetailProductScreenState();
}

class VendorDetailProductScreenState extends State<VendorDetailProductScreen> {
  final String _selectedSize = '';
  final GetSpecificPro pro = GetSpecificPro();
  final GetFeaturedProducts fP = GetFeaturedProducts();
  final GetVendor sP = GetVendor();
  final Cart cart = Cart();
  final Auctions auction = Auctions();

  final AllVendorProducts vendorProducts = AllVendorProducts();
  final GetDiscountedProducts discountedProducts = GetDiscountedProducts();

  final GetChatList chatList = GetChatList();
  int ref = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //print(GetAllProducts.specificProd[1].name);
    //_sP.specificProducts(widget.productId);
    //pro.specificProducts(widget.productId);
    load();
    //print(_sP.name);
  }

  void load() async
  {
    await pro.specificProducts(widget.productId);
    ref = 1;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async{
          setState(() {

          });
          Navigator.pop(context);
          return true;
        },
        child: ref==1?//GetSpecificPro.specificProd.length!=null?
        SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(12),bottomLeft: Radius.circular(12)),
                      image:
                      GetSpecificPro.specificProd[0].productImage !=
                          null
                          ? DecorationImage(
                        image: NetworkImage(
                            "${APILink.imageLink}${GetSpecificPro.specificProd[0].productImage}"),
                        fit: BoxFit.fill,
                      )
                          :
                      const DecorationImage(
                        image: AssetImage(
                            'assets/images/featured_images/shirt.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  //Image
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  children: [
                    Text(
                      GetSpecificPro.specificProd[0].name != null
                          ? GetSpecificPro.specificProd[0].name.toString()
                          : "Product with no Name",
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    // Text(
                    //   GetSpecificPro.specificProd[0].price != null
                    //       ? GetSpecificPro.specificProd[0].price.toString()
                    //       : "",
                    //   style: const TextStyle(fontSize: 18),
                    // ),
                  ],
                ),
              ),

              const SizedBox(height: 8),
              //Available Sizes
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  'Available Sizes:',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              //different Sizes
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    const Spacer(),
                    GetSpecificPro.specificProd[0].small==true?
                    ChoiceChip(
                      padding: const EdgeInsets.all(18),
                      label: const Text('Small'),
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      selected: _selectedSize == 4.toString(),
                      onSelected: (selected) {
                        setState(() {
                          //_selectedSize = size;
                        });
                      },
                    ):const Text(''),
                    const Spacer(),
                    GetSpecificPro.specificProd[0].medium==true?
                    ChoiceChip(
                      padding: const EdgeInsets.all(18),
                      label: const Text('Medium'),
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      selected: _selectedSize == 4.toString(),
                      onSelected: (selected) {
                        setState(() {
                          //_selectedSize = size;
                        });
                      },
                    ):const Text(''),
                    const Spacer(),
                    GetSpecificPro.specificProd[0].large==true?
                    ChoiceChip(
                      padding: const EdgeInsets.all(18),
                      label: const Text('Large'),
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      selected: _selectedSize == 4.toString(),
                      onSelected: (selected) {
                        setState(() {
                          //_selectedSize = size;
                        });
                      },
                    ):const Text(''),
                    const Spacer(),
                    GetSpecificPro.specificProd[0].xLarge==true?
                    ChoiceChip(
                      padding: const EdgeInsets.all(18),
                      label: const Text(
                        'Extra Large',
                        textAlign: TextAlign.center,
                      ),
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      selected: _selectedSize == 4.toString(),
                      onSelected: (selected) {
                        setState(() {
                          //_selectedSize = size;
                        });
                      },
                    ):const Text(''),
                    const Spacer(),
                  ],
                ),
              ),

//detailed images
              GetProductDetailedImages.prodImages.isNotEmpty?
              Center(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      children: [
                        Container(
                          height: 144,
                          width: 144,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 0.5),
                            borderRadius: BorderRadius.circular(12),
                            //const BorderRadius.only(bottomRight: Radius.circular(12),bottomLeft: Radius.circular(12)),
                            image:
                            GetProductDetailedImages.prodImages[0].image1 !=
                                null
                                ? DecorationImage(
                              image: NetworkImage(
                                  "${APILink.imageLink}${GetProductDetailedImages.prodImages[0].image1}"),
                              fit: BoxFit.fill,
                            )
                                :
                            const DecorationImage(
                              image: AssetImage(
                                  'assets/images/featured_images/shirt.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        Container(
                          height: 144,
                          width: 144,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 0.5),
                            borderRadius: BorderRadius.circular(12),
                            // const BorderRadius.only(bottomRight: Radius.circular(12),bottomLeft: Radius.circular(12)),
                            image:
                            GetProductDetailedImages.prodImages[0].image2 !=
                                null
                                ? DecorationImage(
                              image: NetworkImage(
                                  "${APILink.imageLink}${GetProductDetailedImages.prodImages[0].image2}"),
                              fit: BoxFit.fill,
                            )
                                :
                            const DecorationImage(
                              image: AssetImage(
                                  'assets/images/featured_images/shirt.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        Container(
                          height: 144,
                          width: 144,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 0.5),
                            borderRadius: BorderRadius.circular(12),
                            //BorderRadius.only(bottomRight: Radius.circular(12),bottomLeft: Radius.circular(12)),
                            image:
                            GetProductDetailedImages.prodImages[0].image3 !=
                                null
                                ? DecorationImage(
                              image: NetworkImage(
                                  "${APILink.imageLink}${GetProductDetailedImages.prodImages[0].image3}"),
                              fit: BoxFit.fill,
                            )
                                :
                            const DecorationImage(
                              image: AssetImage(
                                  'assets/images/featured_images/shirt.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],),
                  ),
                ),
              ):const SizedBox(height: 0.0,),
              const SizedBox(height: 16),
              //Description
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  'Description:',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  GetSpecificPro.specificProd[0].description != null
                      ? GetSpecificPro.specificProd[0].description.toString()
                      : "No Description",
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    const Text(
                      'Rating:',
                      style: TextStyle(fontSize: 18),
                    ),
                    const Spacer(),
                    AddRatingBar(
                      rating:GetSpecificPro.specificProd[0].productRating!.toDouble(),
                      size: 14,
                    ),

                    // const SizedBox(width: 5),
                    // const Text(
                    //   'Rating',// '(${item.reviews} reviews)',
                    //   style: TextStyle(fontSize: 12),
                    // ),
                  ],
                ),
              ),
              //Reviews
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Item Price:',
                          style: TextStyle(fontSize: 18),
                        ),
                        const Spacer(),
                        Text(
                          GetSpecificPro.specificProd[0].price != null
                              ?
                          "${GetSpecificPro.specificProd[0].price}\$"
                              :
                          "",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    GetSpecificPro.specificProd[0].discountAmount!=null
                        ?
                    Row(
                      children: [
                        const Text(
                          'Discount Price:',
                          style: TextStyle(fontSize: 18),
                        ),
                        const Spacer(),
                        Text(
                          GetSpecificPro.specificProd[0].discountAmount != null
                              ?
                          "${GetSpecificPro.specificProd[0].discountAmount.toString()}\$"
                              :
                          "",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    )
                        :
                    const SizedBox(height: 0,),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              //Add to Cart Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 150,//MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () async{
                          // Add to cart logic here
                          _showCustomAlertDialog(
                            GetSpecificPro.specificProd[0].productID.toString(),
                            GetSpecificPro.specificProd[0].price.toString(),
                            GetSpecificPro.specificProd[0].stockQuantity.toString(),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          backgroundColor: Colors.red,
                        ),
                        // style: ElevatedButton.styleFrom(
                        //     backgroundColor: Colors.red,
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(33)
                        //     )
                        // ),
                        child: const Text('Update'),
                      ),
                    ),
                    const SizedBox(width: 6,),
                    SizedBox(
                      height: 40,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () async{
                          // Add your login logic here
                          _discountAlertDialog(
                            GetSpecificPro.specificProd[0].productID.toString(),
                            GetSpecificPro.specificProd[0].price.toString(),
                            //AllVendorProducts.vendorProducts[index].stockQuantity.toString(),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          backgroundColor: Colors.red,
                        ),
                        child: const Text('Add Discount',),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () async{
                          // delete Product
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          backgroundColor: Colors.red,
                        ),
                        child: const Text('Delete Product',),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ):
        const Center(child: CircularProgressIndicator(color: Colors.black,),),
      ),
    );
  }
  _discountAlertDialog(id,price) {
    TextEditingController newPriceController = TextEditingController();
    //TextEditingController priceController = TextEditingController();
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Discount on Product:'),
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              //color: const Color(0xffF8F8FF),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xffF8F8FF),
                  ),
                  child: TextFormField(
                    controller: newPriceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Enter new Amount',
                      contentPadding: EdgeInsets.all(10.0),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async{
                // Do something with the text from the text field
                //String enteredText = newPriceController.text;
                if(newPriceController.text.isNotEmpty)
                {
                  await discountedProducts.addDiscountOnProducts(id, newPriceController.text);
                  await vendorProducts.getVendorProducts(AllVendorProducts.vendorProducts[0].email);
                  setState(() {});
                  Navigator.of(context).pop();
                }

                // Close the dialog
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  _showCustomAlertDialog(id,price,quan) {
    TextEditingController quantityController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    //final AllVendorProducts vendorProducts = AllVendorProducts();
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update your product:'),
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              //color: const Color(0xffF8F8FF),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xffF8F8FF),
                  ),
                  child: TextFormField(
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Update your stock',
                      contentPadding: EdgeInsets.all(10.0),
                      border: InputBorder.none,
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
                    controller: priceController,
                    //initialValue: price,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Update price',
                      contentPadding: EdgeInsets.all(10.0),
                      border: InputBorder.none,
                    ),
                    onChanged: (value){
                      // price = value;
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async{
                // Do something with the text from the text field
                //String enteredText = quantityController.text;
                if(quantityController.text.isNotEmpty && priceController.text.isNotEmpty)
                {
                  await vendorProducts.updateProduct(id, priceController.text, quantityController.text);
                  await vendorProducts.getVendorProducts(AllVendorProducts.vendorProducts[0].email);
                  setState(() {});
                  Navigator.of(context).pop();
                }

                // Close the dialog
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

// shareWidget(share) async{
//   if(share == "Share Item") {
//
//     // final res = await http.get(Uri.parse("${APILink.link}Product/GetProductImage?id=${GetSpecificPro.specificProd[0].productID}"));
//     // print(res.body);print(res.bodyBytes);
//     // final bytes = res.bodyBytes;
//     // final temp = await getTemporaryDirectory();
//     // final path = "${temp.path}/${res.body}";
//     // final p = File(path).writeAsBytesSync(bytes);
//
//     await Share.share(
//       subject:"${GetSpecificPro.specificProd[0].name}",
//       "${APILink.imageLink}${GetSpecificPro.specificProd[0].productImage}",
//     );
//   }
// }
}
