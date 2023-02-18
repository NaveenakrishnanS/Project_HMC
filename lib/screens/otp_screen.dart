import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:project_hmc/screens/chat_screen.dart';


class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics:const BouncingScrollPhysics(),
        child:Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical:45, horizontal: 35),
            child:Column(
                children: [
                  Container(
                    width: 300,
                    height: 290,
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset(
                       'assets/reg.png',
                        fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height:46),
                  const Text(
                     "VERIFICATION",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                const SizedBox(height:23),
                const Text("We will verify your phone number by sending an OTP code.",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                   ),
                 textAlign: TextAlign.center,
                ),
                const SizedBox(height: 35),
                 OtpTextField(
                        numberOfFields: 6,
                        borderColor: Colors.blue,
                        fieldWidth: 40,
                        showFieldAsBox: true,
                        borderWidth: 2.0,
                        ),
               Padding(
                 padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                 child: TextButton(child: const Text("Resend Code"), onPressed: () {  },),
               ),
               const SizedBox(height: 25),
                     SizedBox(
                        height: 50,
                        width: 145,
                        child: ElevatedButton(onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ChatScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),),
                        child: const Text("VERIFY",style: TextStyle(fontSize: 20,),),
                        ),
                       ),
              ],

            ),
          ),
        ),
      ),

    );
  }
}

