import 'package:flutter/material.dart';

class VendorCard extends StatelessWidget {
  final String name;
  final String address;
  //final String phoneNumber;
  //final String gstNumber;

  const VendorCard({super.key,
    required this.name,
    required this.address,
    //required this.phoneNumber,
    //required this.gstNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(),
      elevation: 0,
      shadowColor: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal:20, vertical: 0),
      child:  Container(
      height: 116,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(0),
      ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          leading: Container(
            padding: const EdgeInsets.only(right: 12),
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 1,
                  color: Colors.blue,
                ),
              ),
            ),
            child: Image.asset(
              'assets/laundry.png',
            ),
          ),
          title: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text(
                address,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
