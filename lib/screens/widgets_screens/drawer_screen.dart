import 'package:flutter/material.dart';
import 'package:kwale/models/user_model/UserInfoModel.dart';
class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 50,),
          // DrawerHeader(
          //   decoration: const BoxDecoration(
          //     color: Colors.blue,
          //   ),
          //   child: Text(
          //     fetchInfo.name.toString(),
          //     style: const TextStyle(
          //       color: Colors.white,
          //       fontSize: 24,
          //     ),
          //   ),
          // ),
          ListTile(
            leading: const Icon(Icons.local_offer_outlined),
            title: const Text('Hot Deals'),
            onTap: () {
              // Handle onTap for Home ListTile
            },
          ),
          ListTile(
            leading: const Icon(Icons.branding_watermark),
            title: const Text('Brands'),
            onTap: () {
              // Handle onTap for Settings ListTile
            },
          ),
          ListTile(
            leading: const Icon(Icons.category_outlined),
            title: const Text('Categories'),
            onTap: () {
              // Handle onTap for About ListTile
            },
          ),
        ],
      ),
    );
  }
}
