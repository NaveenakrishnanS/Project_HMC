import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final countryPicker = const  FlCountryCodePicker();
  final countryPickerWithParams = const FlCountryCodePicker(
    localize: true,
    showDialCode: true,
    showFavoritesIcon: false,
    showSearchBar: true,
    title: Text('data'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body:SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 300,
            height: 290,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Image.asset(
                'assets/login.jpg',
              fit: BoxFit.contain,
            ),
          ),
          const Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: Text('Welcome',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40
          ),
          ),
      ),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 100, 200, 10),
            child: Text('Phone Number',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            ),
          ),
          Padding(padding: const EdgeInsets.fromLTRB(30, 0, 60, 0),
          child: TextField(
            keyboardType: TextInputType.phone,
            style: const TextStyle(
              fontSize: 20
            ),
            decoration: InputDecoration(

              //border: InputBorder.none,
              border: const OutlineInputBorder(),
              //label: Text('Phone number'),
              prefixIcon:  Container(
                padding:const EdgeInsets.fromLTRB(10, 0, 0, 0),
                margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        // Show the country code picker when tapped.
                      final code = await countryPicker.showPicker(context: context);
                      if (code != null) print(code);
                    },
                    child: Container(
                    child:const Text('+1')
                    ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          )
    ]
      ),
      ),
    );
  }
}
