// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:project_hmc/firebase/auth/firebase_auth.dart';
import 'package:project_hmc/firebase/cloud_database.dart';
import 'package:project_hmc/models/user_model.dart';
import 'package:project_hmc/screens/navigation_screen.dart';
import 'package:project_hmc/screens/widget_handler.dart';

import '../firebase/key_managers/rsa_key_manager.dart';

class Register extends StatefulWidget {
  const Register({Key? key, required this.phoneNumber}) : super(key: key);
  final String phoneNumber;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _aboutController = TextEditingController();
  final sb = WidgetHandler();

  bool alreadyExists = false;
  late String phoneNumber;

  @override
  void initState() {
    super.initState();
    phoneNumber = widget.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    final _phoneController = TextEditingController(text: widget.phoneNumber);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
          backgroundColor: Colors.black,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 40, top: 30),
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Colors.white,
                child: Image(
                    image: AssetImage("assets/chat_symbol.png"),
                    color: Colors.black87),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color(0xffD8E4F7)),
              padding: const EdgeInsets.all(16),
              child: FutureBuilder<UserModel>(
                future: CloudDatabase().retrieveUserDetails(
                    UID: FirebaseAuthentication.getUserUid),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    UserModel userModel = snapshot.data as UserModel;
                    _nameController.text = userModel.Name;
                    _aboutController.text = userModel.About;
                    _emailController.text = userModel.Email;
                    _phoneController.text = userModel.Phone;
                    alreadyExists = true;
                  } else {
                    _nameController.text = "";
                    _aboutController.text = "";
                    _emailController.text = "";
                    _phoneController.text = phoneNumber;
                    alreadyExists = false;
                  }
                  return Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Name',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          controller: _nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'About',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          controller: _aboutController,
                          maxLines: null,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Email',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          controller: _emailController,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Phone',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          controller: _phoneController,
                          readOnly: true,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 32),
                        Center(
                          child: SizedBox(
                            height: 50,
                            width: 145,
                            child: ElevatedButton(
                              onPressed: _changes,
                              style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  backgroundColor: Colors.black),
                              child: const Text(
                                'Register',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ))));
  }

  void _changes() async {
    if (_nameController.text != "" &&
        _emailController.text != "" &&
        _aboutController.text != "") {
      UserModel userdata = UserModel(
          Name: _nameController.text,
          UID: FirebaseAuthentication.getUserUid,
          Phone: phoneNumber,
          About: _aboutController.text,
          Email: _emailController.text);
      CloudDatabase().addUserDetails(userdata: userdata);
      _keys();
      if (alreadyExists) {
        sb.showSnackBar(
            context, "You are already a Registered User! Changes Saved!");
      } else {
        sb.showSnackBar(context, "You are successfully registered!");
      }

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const NavigationScreen(),
          ),
          (Route<dynamic> route) => false);
    }
  }

  void _keys() async {
    // Generate RSA key pair
    final rsaKeyPair = await RSAKeyManager().generateRsaKeyPair();
    // Save RSA public key and private key
    await RSAKeyManager().generateKeysAndSave(rsaKeyPair);
  }
}
