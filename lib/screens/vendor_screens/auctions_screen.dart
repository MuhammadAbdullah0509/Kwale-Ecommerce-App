// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kwale/models/vendorModels/AuctionModel.dart';
import 'package:kwale/models/vendorModels/GetSpecificVendor.dart';
import 'package:kwale/screens/widgets_screens/flutter_toast.dart';
import 'package:kwale/screens/widgets_screens/http_link.dart';

import '../../../models/post_controler/OwnUsersPost.dart';

class AuctionScreen extends StatefulWidget {
  const AuctionScreen({super.key});

  @override
  _AuctionScreenState createState() => _AuctionScreenState();
}

class _AuctionScreenState extends State<AuctionScreen> {
  final TextEditingController _itemName = TextEditingController();
  final TextEditingController _itemDescription = TextEditingController();
  String? selectedCategory;

  List<String> categories = [
    // Add more categories here
    'Men',
    'Women',
    'Kids',
    'Home & Accessories',
    'Beauty',
  ];
  final Auctions auctions = Auctions();
  List<File> selectedImages = [];
  File? file;

  void _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        if(selectedImages.length<3) {
          selectedImages.add(File(pickedImage.path));
          file = File(pickedImage!.path);
          print(file);
        }
        else {
          selectedImages.removeAt(0);
          selectedImages.add(File(pickedImage.path));
          print(selectedImages.first.path);
          FlutterToast.showToast('Only 3 image u can select');
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            // Perform search action
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Add Auction',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // const SizedBox(height: 30),
              // Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(12),
              //     color: const Color(0xffF8F8FF),
              //   ),
              //   child: DropdownButtonFormField(
              //     value: selectedCategory,
              //     items: categories.map((category) {
              //       return DropdownMenuItem(
              //         value: category,
              //         child: Text(category),
              //       );
              //     }).toList(),
              //     onChanged: (value) {
              //       setState(() {
              //         selectedCategory = value;
              //       });
              //     },
              //     decoration: const InputDecoration(
              //       labelText: 'Select Category',
              //       labelStyle: TextStyle(color: Colors.black),
              //     ),
              //   ),
              // ),
              const SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xffF8F8FF),
                ),
                child: TextField(
                  controller: _itemName,
                  decoration: InputDecoration(
                    labelText: 'Item Name',
                    labelStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // Text area for a long review
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xffF8F8FF),
                ),
                child: TextField(
                  controller: _itemDescription,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: selectedImages.isNotEmpty ? 400 : 10,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: selectedImages.length,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          //borderRadius: BorderRadius.circular(12),
                            border: Border.all(width: 1)
                        ),
                        child: Image.file(selectedImages[index]));
                  },
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.height,
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
                        Text('Upload Image',),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              //const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async{
                  // Add logic to save the post and navigate to another screen or perform any action.
                  if(selectedImages.length<3)
                  {
                    FlutterToast.showToast("please select 3 images");
                  }else {
                    await auctions.addAuctions(
                      GetVendor.specificVendor[0].email,
                      _itemName.text,
                      _itemDescription.text,
                      selectedImages[0].path,
                      selectedImages[1].path,
                      selectedImages[2].path,
                  );
                    await auctions.getVendorAuctions(GetVendor.specificVendor[0].email);
                    Navigator.pop(context);
                  }

                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )
                ),
                child: const Text('Add Auctions'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
