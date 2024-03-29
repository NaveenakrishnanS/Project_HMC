import 'package:flutter/material.dart';
import 'package:project_hmc/firebase/auth/firebase_auth.dart';
import 'package:project_hmc/firebase/cloud_database.dart';
import 'package:project_hmc/models/user_model.dart';
import 'package:project_hmc/screens/widget_handler.dart';

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
  final sb = WidgetHandler();
  late bool _isEditing = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          leadingWidth: 200,
          elevation: 0,
          backgroundColor: Colors.black,
          leading: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: const EdgeInsets.only(top: 15, left: 20),
                child: Row(
                  children: const [
                    Icon(
                      Icons.person,
                      size: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 28),
                      child: Text(
                        'Profile',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 40, top: 20),
          child: CircleAvatar(
            radius: 70,
            // backgroundColor: Colors.black,
            child: Image(
              image: AssetImage("assets/user.png"),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: const Color(0xffD8E4F7)),
          padding: const EdgeInsets.all(16),
          child: FutureBuilder<UserModel>(
            future: CloudDatabase()
                .retrieveUserDetails(UID: FirebaseAuthentication.getUserUid),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                UserModel userModel = snapshot.data as UserModel;
                _nameController.text = userModel.Name;
                _aboutController.text = userModel.About;
                _emailController.text = userModel.Email;
                _phoneController.text = userModel.Phone;
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
                        readOnly: !_isEditing,
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
                        readOnly: !_isEditing,
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
                        readOnly: !_isEditing,
                        controller: _emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Email ID';
                          }
                          return null;
                        },
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
                          child: ElevatedButton.icon(
                            onPressed: _changes,
                            style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                backgroundColor: Colors.black),
                            icon: Icon(_isEditing
                                ? Icons.save_as_outlined
                                : Icons.edit_sharp),
                            label: Text(_isEditing ? 'Save' : 'Edit'),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    strokeWidth: 5,
                  ),
                );
              }
            },
          ),
        )
      ])),
    );
  }

  void _onButtonPressed() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _changes() async {
    _onButtonPressed();
    if (_formKey.currentState!.validate()) {
      CloudDatabase().addUserDetails(
          userdata: UserModel(
              Name: _nameController.text,
              UID: FirebaseAuthentication.getUserUid,
              Phone: _phoneController.text,
              About: _aboutController.text,
              Email: _emailController.text));
      if (_isEditing) {
        sb.showSnackBar(context, "Start Changing!");
      } else {
        sb.showSnackBar(context, "Changes are Saved!");
      }
    }
  }
}
