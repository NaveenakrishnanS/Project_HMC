import 'package:flutter/material.dart';
class ReplyMessage extends StatefulWidget {
  const ReplyMessage({Key? key}) : super(key: key);

  @override
  State<ReplyMessage> createState() => _ReplyMessageState();
}
class _ReplyMessageState extends State<ReplyMessage> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width-45,
        ),
        child:Card(
          color:const Color.fromRGBO(225, 105, 162, 10),
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
          margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
          child: Stack(
            children: [
              const Padding(padding: EdgeInsets.only(left:10, top: 10,right: 30, bottom: 20),
                child: Text("Hello World, Welcome to Air Message Mukesh Kumar Naveenakrishnan Ganeshamurthy",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),),
              ),
              Positioned(
                bottom:2,
                right: 3,
                child:Row(
                  children:  const [
                    Text("00:00",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white70,
                      ),),
                    SizedBox(
                      width: 5,),
                  ],
                ), ),
            ],
          ),
        ),
      ),
    );
  }
}
