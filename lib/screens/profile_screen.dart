import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _aboutController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
            child: Column(children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 40, top: 30),
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.black,
                  child: Image(image: AssetImage("assets/chat_symbol.png"),color: Colors.white),
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Name',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        controller: _emailController,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Phone',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                              'Edit',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),],)
        ));
  }

  void _changes() async {
    _saveChanges();
  }

  void _saveChanges() async {
    /*if (_formKey.currentState!.validate()) {
      final user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance.collection('Vendors').doc(user!.uid).collection('Details').doc('Info').set({
        'name': _nameController.text,
        'phone': _phoneController.text,
        'about': _aboutController.text,
        'gstNo': _gstNoController.text,
      },

          SetOptions(merge: true));


      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Changes saved!')));
    }*/
  }
}
