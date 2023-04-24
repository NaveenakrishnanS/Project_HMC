import 'package:flutter/material.dart';
import 'package:project_hmc/screens/message_card/receive_card.dart';
import 'package:project_hmc/screens/message_card/send_card.dart';

class SingleChat extends StatefulWidget {
  const SingleChat({Key? key, required this.name,required this.uID}) : super(key: key);
  final String name, uID;
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
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(65),
            child: AppBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              automaticallyImplyLeading: true,
              leadingWidth: 350,
              elevation: 0,
              backgroundColor: Colors.black,
              leading: Align(
                child: Padding(
                    padding: const EdgeInsets.only(top: 15, left: 10),
                    child: Row(
                      children:  [
                        CircleAvatar(
                          child: Image.asset(
                            'assets/user.jpg'
                          ),
                        ),
                        // const Icon(
                        //   Icons.person,
                        //   color: Colors.amber,
                        //   weight: Checkbox.width,
                        //   size: 40,
                        // ),
                        const SizedBox(
                          width: 7,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            widget.name,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )),
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
                  height: MediaQuery.of(context).size.height - 160,
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 15),
                    shrinkWrap: true,
                    children: const [
                      InputMessage(text: 'Hii'),
                      ReplyMessage(text: 'Hi'),
                      InputMessage(text: 'How are you?'),
                      ReplyMessage(text: 'Fine'),
                      ReplyMessage(text: 'How about you?'),
                      InputMessage(text: 'Great Life'),
                      ReplyMessage(text: 'Enjoying developer\'s Life'),
                      InputMessage(text: 'Yeah'),
                      InputMessage(text: 'How is it being Entrepreneur?'),
                      ReplyMessage(text: 'yeah, Going Great'),
                      InputMessage(text: 'Send me the pics'),
                      ReplyMessage(text: 'Fine'),
                      ReplyMessage(text: 'do you need all?'),
                      InputMessage(text: 'Yeah, man'),
                      ReplyMessage(text: 'ok Cool!'),
                      InputMessage(text: 'Hmm'),
                      ReplyMessage(text: 'Mmmm'),
                      InputMessage(text: 'Check Your Mail'),
                      ReplyMessage(text: 'Wait a second! Let me check it'),
                      ReplyMessage(text: 'Ok! All looks great'),
                      InputMessage(text: 'I too felt it same as you are'),
                      ReplyMessage(text: 'Ok! Bye! Got to go!'),
                      InputMessage(text: 'Bye! Bye!'),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 2.0),
                          child: TextField(
                            controller: _controller,
                            style: const TextStyle(
                                fontSize: 20.0, color: Colors.black87),
                            decoration: InputDecoration(
                              hintText: 'Type a message',
                              suffixIcon: IconButton(
                                splashRadius: 10,
                                icon: const Icon(Icons.attach_file_rounded),
                                color: Colors.grey,
                                onPressed: () {},
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.only(
                                  left: 20.0,
                                  bottom: 8.0,
                                  top: 8.0,
                                  right: 16.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.black,borderRadius: BorderRadius.circular(30),
                        child: IconButton(
                          splashRadius: 20,
                          onPressed: () {},
                          splashColor: Colors.black87,hoverColor: Colors.black87,
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                          iconSize: 28,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
