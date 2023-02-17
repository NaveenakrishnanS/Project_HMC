import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';


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
            padding: const EdgeInsets.symmetric(vertical:25, horizontal: 35),
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
                  const SizedBox(height:20),
                  const Text(
                     "VERIFICATION",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                const SizedBox(height:10),
                const Text("We will verify your phone number by sending an OTP code.",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                   ),
                 textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                 OtpTextField(
                        numberOfFields: 6,
                        borderColor: Colors.blue,
                        fieldWidth: 40,
                        showFieldAsBox: true,
                        borderWidth: 2.0,
                        ),
               TextButton(child: const Text("Resend Code"), onPressed: () {  },),
               const SizedBox(height: 10),
                     SizedBox(
                        height: 50,
                        width: 145,
                        child: ElevatedButton(onPressed: (){},
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

