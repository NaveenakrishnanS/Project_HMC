import 'package:flutter/material.dart';
//import 'package:hygiene_app/firebase/database/cloud_database.dart';
import 'package:project_hmc/screens/Friend_list/Widgets/vendor_card.dart';

class Vendor {
  final String name;
  final String address;

  Vendor({
    required this.name,
    required this.address,
  });
}

class VendorList extends StatefulWidget {
  const VendorList({super.key});

  @override
  VendorListState createState() => VendorListState();
}

class VendorListState extends State<VendorList> {
  final List<Vendor> vendorList = [
    Vendor(
      name: 'Vendor 1',
      address: '123 Main St.,Gandhi Nagar,Chennai-01',
    ),
    Vendor(
      name: 'Vendor 2',
      address: '456 Main St.,Gandhi Nagar,Delhi',
    ),
    Vendor(
      name: 'Vendor 3',
      address: '789 Main Street,Gandhi Nagar,Mumbai',
    ),
    Vendor(
      name: 'Vendor 4',
      address: '123 Main St.,Gandhi Nagar,Chennai-01',
    ),
    Vendor(
      name: 'Vendor 5',
      address: '456 Main St.,Gandhi Nagar,Delhi',
    ),
    Vendor(
      name: 'Vendor 6',
      address: '789 Main Street,Gandhi Nagar,Mumbai',
    ),
    Vendor(
      name: 'Vendor 7',
      address: '123 Main St.,Gandhi Nagar,Chennai-01',
    ),
    Vendor(
      name: 'Vendor 8',
      address: '456 Main St.,Gandhi Nagar,Delhi',
    ),
    Vendor(
      name: 'Vendor 9',
      address: '789 Main Street,Gandhi Nagar,Mumbai',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendor List'),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: vendorList.length,
          itemBuilder: (context, index) {
            return VendorCard(
                name: vendorList[index].name,
                address: vendorList[index].address);
          },
        ),
      ),
    );
  }
}
