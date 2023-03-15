import 'package:flutter/material.dart';
import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter/services.dart';
import 'package:project_hmc/firebase/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  Country? _selectedCountry;
  final _text = TextEditingController();
  late final bool _validate = false;

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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                width: 300,
                height: 290,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Image.asset(
                  'assets/login.jpg',
                  fit: BoxFit.contain,
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'WELCOME',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(60, 20, 60, 0),
                child: Text(
                  'Enter your phone number to get started with MessageAir',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(30, 40, 0, 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Phone Number',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: TextFormField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  controller: _text,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    errorText: _validate ? 'Enter the Phone Number' : null,
                    //border: InputBorder.none,
                    border: const OutlineInputBorder(),
                    //label: const Text('Phone number'),
                    prefixIcon: Container(
                      padding: const EdgeInsets.fromLTRB(8, 0, 5, 0),
                      margin: const EdgeInsets.fromLTRB(8, 0, 5, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final country = await showCountryPickerSheet(
                                context,
                              );
                              if (country != null) {
                                setState(() {
                                  _selectedCountry = country;
                                });
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(4, 3, 4, 3),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                '${country?.callingCode}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                child: SizedBox(
                  height: 50,
                  width: 145,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!_validate && _selectedCountry != null) {
                        String phoneNumber = "${_selectedCountry!.callingCode} ${_text.text}";
                        FirebaseAuthentication.getOTPonPhoneNumber(
                            number: phoneNumber, context: context);
                      }
                    },
                    style:
                        ElevatedButton.styleFrom(shape: const StadiumBorder()),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
/*
Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Register(phoneNumber: phoneNumber),
                          ),
                        );
 */