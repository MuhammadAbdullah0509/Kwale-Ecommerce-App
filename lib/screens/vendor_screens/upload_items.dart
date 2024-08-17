// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:kwale/models/user_model/UserInfoModel.dart';
import 'package:kwale/models/vendorModels/GetSpecificVendor.dart';
import 'package:kwale/models/vendorModels/VendorProducts.dart';

import '../widgets_screens/flutter_toast.dart';

class VendorUploadItems extends StatefulWidget {
  const VendorUploadItems({super.key});

  @override
  _VendorUploadItemsState createState() => _VendorUploadItemsState();
}

class _VendorUploadItemsState extends State<VendorUploadItems> {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemDescriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  List<File> selectedImages = [];
  bool _isCheckedSmall = false;
  bool _isCheckedMedium = false;
  bool _isCheckedLarge = false;
  bool _isCheckedXLarge = false;
  AllVendorProducts vendorProducts = AllVendorProducts();
  String? selectedCategory;
  List<String> categories = [
    'Men',
    'Women',
    'Kids',
    'Home & Accessories',
    'Beauty',
  ];
  File? file;
  void _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        //selectedImages.add(File(pickedImage.path));
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
        title: const Text('Upload Product',style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xffF8F8FF),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: DropdownButtonFormField(
                  value: selectedCategory,
                  items: categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Select Category',
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xffF8F8FF),
              ),
              child: TextFormField(
                controller: itemNameController,
                decoration: InputDecoration(
                    labelText: 'Item Name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            //price
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xffF8F8FF),
              ),
              child: TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Item price',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            //stock/quantity
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xffF8F8FF),
              ),
              child: TextFormField(
                controller: stockController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Available stock',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            //description
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xffF8F8FF),
              ),
              child: TextFormField(
                controller: itemDescriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                    labelText: 'Item Description',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('Available Size',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xffF8F8FF),
              ),
              child: Column(
                children: [
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text('Small'),
                    value: _isCheckedSmall,
                    onChanged: (newValue) {
                      setState(() {
                        _isCheckedSmall = newValue ?? false;
                      });
                    },
                  ),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text('Medium'),
                    value: _isCheckedMedium,
                    onChanged: (newValue) {
                      setState(() {
                        _isCheckedMedium = newValue ?? false;
                      });
                    },
                  ),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text('Large'),
                    value: _isCheckedLarge,
                    onChanged: (newValue) {
                      setState(() {
                        _isCheckedLarge = newValue ?? false;
                      });
                    },
                  ),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text('X Large'),
                    value: _isCheckedXLarge,
                    onChanged: (newValue) {
                      setState(() {
                        _isCheckedXLarge = newValue ?? false;
                      });
                    },
                  ),
                ],
              ),
            ),
            // ElevatedButton(
            //   onPressed: _pickImage,
            //   child: const Text('Select Images'),
            // ),
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
            SizedBox(
              width: MediaQuery.of(context).size.height,
              height: 60,
              child: ElevatedButton(
                onPressed: () async {
                  if(selectedImages.length<3)
                  {
                    FlutterToast.showToast("please select 3 images");
                  }else {
                    await vendorProducts.addProduct(
                      //GetVendor.specificVendor[0].email.toString(),
                        fetchInfo.userEmail.toString(),
                        itemNameController.text,
                        itemDescriptionController.text,
                        priceController.text,
                        stockController.text,
                        selectedCategory,
                        _isCheckedSmall,
                        _isCheckedMedium,
                        _isCheckedLarge,
                        _isCheckedXLarge,
                    //selectedImages.first.path,
                        selectedImages[0].path,
                        selectedImages[1].path,
                        selectedImages[2].path,
                  );
                    await vendorProducts.getVendorProducts(fetchInfo.userEmail.toString());
                    Navigator.pop(context);
                  }
                  //Navigator.pop(context);
                },//_pickImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Save Item',),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
