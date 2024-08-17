// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:kwale/screens/home_screen/review_screen/add_review_screen.dart';
import 'package:kwale/screens/home_screen/review_screen/review_screen.dart';
import 'package:kwale/screens/widgets_screens/http_link.dart';
import 'package:kwale/screens/widgets_screens/rating_bar.dart';

import '../../../models/user_model/UserAddress.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  String _selectedCountryCode = '+260';
  final GetUserAddress gP = GetUserAddress();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _provinceController.text = 'Lusaka';
    _countryController.text = 'Zambia';
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
        title: const Text('Address',style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20.0),
            buildTextField('Name',_nameController,false),
            const SizedBox(height: 16.0),
            Container(
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xffF8F8FF),
                border: Border.all(width: 0.1),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: InternationalPhoneNumberInput(
                  searchBoxDecoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onInputChanged: (PhoneNumber number) {
                    //print(number.phoneNumber);
                    _phoneController.text = number.phoneNumber.toString();
                    print(_phoneController.text);

                  },
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.DIALOG,
                  ),
                  ignoreBlank: false,
                  autoValidateMode: AutovalidateMode.disabled,
                  selectorTextStyle: const TextStyle(color: Colors.black,),
                  initialValue: PhoneNumber(
                    isoCode: 'ZM',
                    dialCode: _selectedCountryCode,
                  ),
                  textStyle: const TextStyle(fontSize: 16.0),
                  cursorColor: Colors.black,
                  inputDecoration: InputDecoration(
                    labelText: 'Phone Number',
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),

                  ),
                  //if only the selected countries shown in drop down
                  countries: const ['ZM'], // Add other country codes as needed
                  // onChanged: (PhoneNumber number) {
                  //   print(number.phoneNumber);
                  // },
                  onSaved: (PhoneNumber number) {
                    print('Country code: ${number.dialCode}');
                    print('Phone number: ${number.phoneNumber}');
                    _phoneController.text = "${number.dialCode}${number.phoneNumber}";
                    print(_phoneController.text);
                  },
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            buildTextField('Country',_countryController,true),
            const SizedBox(height: 16.0),
            buildTextField('Province',_provinceController,true),
            const SizedBox(height: 16.0),
            buildTextField('City',_cityController,false),
            const SizedBox(height: 16.0),
            buildTextField('Address',_streetController,false),
            const SizedBox(height: 32.0),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: () async {
                  // Add functionality to save address here
                  print(_phoneController.text.toString());
                 await gP.addAddress(
                      APILink.defaultEmail,
                      _phoneController.text,
                      _cityController.text,
                      _streetController.text,
                  );
                 await gP.getAddress(APILink.defaultEmail);
                 Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  //padding: const EdgeInsets.symmetric(vertical: 16.0),
                  //textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('Save Address'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String labelText,controller,readonly) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xffF8F8FF),
      ),
      child: TextField(
        controller: controller,
        cursorColor: Colors.black,
        readOnly: readonly,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.black,),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}

