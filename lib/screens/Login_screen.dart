import 'package:flutter/material.dart';
import 'package:country_calling_code_picker/picker.dart';
import 'package:project_hmc/screens/otp_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Country? _selectedCountry;

  @override
  void initState() {
    initCountry();
    super.initState();
  }

  void initCountry() async {
    final country = await getDefaultCountry(context);
    setState(() {
      _selectedCountry = country;
    });
  }

  @override
  Widget build(BuildContext context) {
    final country = _selectedCountry;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body:SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50,),
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
            padding: EdgeInsets.fromLTRB(10, 70, 200, 10),
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
                      onTap: ()
                        async {
                          final country = await showCountryPickerSheet(
                            context,
                          );
                          if (country != null) {
                            setState(() {
                              _selectedCountry = country;
                            }
                            );
                          }
                        },
                    child: Text('${country?.callingCode}' ' ',
                    style: TextStyle(
                      fontSize: 19,
                    ),
                    ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ),
          Padding(padding: const EdgeInsets.fromLTRB(0,80 , 0, 0),
            child:SizedBox(
              height: 50,
              width: 145,
          child: ElevatedButton(onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OTPScreen())
            );
          },
                child:Text(
                'Login',
                style: TextStyle(fontSize: 20),
              ),
            style: ElevatedButton.styleFrom(
                shape: StadiumBorder()),
          ),
          ),
          ),
    ]
      ),
      ),
    );
  }
}
