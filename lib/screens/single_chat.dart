import 'package:flutter/material.dart';
import 'package:project_hmc/screens/message_card/receive_card.dart';
import 'package:project_hmc/screens/message_card/send_card.dart';


class SingleChat extends StatefulWidget {
  const SingleChat({Key? key}) : super(key: key);

  @override
  State<SingleChat> createState() => _SingleChatState();
}

class _SingleChatState extends State<SingleChat> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /*Image.asset('assets/whte.png',
         height: MediaQuery.of(context).size.height,
         width: MediaQuery.of(context).size.width,
         fit: BoxFit.cover,),*/
        Scaffold(
          backgroundColor: Colors.white,
            appBar:PreferredSize(
              preferredSize: const Size.fromHeight(65),
              child: AppBar(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                automaticallyImplyLeading: true,
                leadingWidth: 200,
                elevation: 0,
                backgroundColor: Colors.black,
                leading:  Align(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 15, left: 20),
                      child: Row(
                        children: const [
                          CircleAvatar(),
                          SizedBox(width:7,),
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              'Mike',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                ),
              ),
            ),
          resizeToAvoidBottomInset: true,
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                 Container(
                   color: Colors.white,
                   height: MediaQuery.of(context).size.height-160,
                   child: ListView(
                     padding: const EdgeInsets.only(bottom: 15),
                      shrinkWrap: true,
                      children: const [
                        InputMessage(),
                        ReplyMessage(),
                        InputMessage(),
                        ReplyMessage(),
                        InputMessage(),
                        ReplyMessage(),
                        InputMessage(),
                      ],
                    ),
                 ),
                Align(
                alignment: Alignment.bottomCenter,
                child:
                  Row(
                    children: [
                      Expanded(
                        child:Container(
                          padding:const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
                        child:TextField(
                       controller: _controller,
                       style:  const TextStyle(
                        fontSize: 20.0, color: Colors.black87),
                        decoration: InputDecoration(
                        hintText: 'Type a message',
                        suffixIcon:IconButton(splashRadius:10,
                        icon: const Icon(Icons.attach_file_rounded),
                        color: Colors.grey,
                        onPressed:(){},
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.only(left: 20.0, bottom: 8.0, top: 8.0, right: 16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
              ),
                      ),
          ),
                      Material(
                        color: Colors.transparent,
                        child: IconButton(
                            splashRadius: 15,
                            onPressed: () {},
                            icon: const Icon(
                              Icons.send,
                              color: Colors.black,
                            ),
                        iconSize: 28,),
                      ),
                    ],
                  ),),
              ],
                ),),
        ),

      ],


    );

  }

}
