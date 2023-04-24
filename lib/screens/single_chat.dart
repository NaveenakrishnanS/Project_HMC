import 'package:flutter/material.dart';
import 'package:project_hmc/screens/message_card/receive_card.dart';
import 'package:project_hmc/screens/message_card/send_card.dart';

class SingleChat extends StatefulWidget {
  const SingleChat({Key? key, required this.name, required this.uID})
      : super(key: key);
  final String name, uID;

  @override
  State<SingleChat> createState() => _SingleChatState();
}

class _SingleChatState extends State<SingleChat> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List _messages = [
    const InputMessage(text: 'Hii'),
    const ReplyMessage(text: 'Hi'),
    const InputMessage(text: 'How are you?'),
    const ReplyMessage(text: 'Fine'),
    const ReplyMessage(text: 'How about you?'),
    const InputMessage(text: 'Great Life'),
    const ReplyMessage(text: 'Enjoying developer\'s Life'),
    const InputMessage(text: 'Yeah'),
    const InputMessage(text: 'How is it being Entrepreneur?'),
    const ReplyMessage(text: 'yeah, Going Great'),
    const InputMessage(text: 'Send me the pics'),
    const ReplyMessage(text: 'Fine'),
    const ReplyMessage(text: 'do you need all?'),
    const InputMessage(text: 'Yeah, man'),
    const ReplyMessage(text: 'ok Cool!'),
    const InputMessage(text: 'Hmm'),
    const ReplyMessage(text: 'Mmmm'),
    const InputMessage(text: 'Check Your Mail'),
    const ReplyMessage(text: 'Wait a second! Let me check it'),
    const ReplyMessage(text: 'Ok! All looks great'),
    const InputMessage(text: 'I too felt it same as you are'),
    const ReplyMessage(text: 'Ok! Bye! Got to go!'),
    const InputMessage(text: 'Bye! Bye!'),
  ];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Scroll to the end of the list on page load
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }
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
                        children: [
                          CircleAvatar(
                            child: Image.asset('assets/user.jpg'),
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
                    padding: const EdgeInsets.only(top: 0),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: SingleChildScrollView(
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.only(bottom: 80),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          return _messages[index];
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.transparent, width: 1),
                        ),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, bottom: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: TextField(
                                    controller: _controller,
                                    decoration: const InputDecoration(
                                      hintText: 'Type your message...',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {
                              InputMessage input =
                              InputMessage(text: _controller.text);
                              setState(() {
                                _messages.add(input);
                              });
                              _controller.clear();
                              _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration:  const Duration(milliseconds: 500),
                                curve: Curves.fastOutSlowIn,
                              );
                              FocusScope.of(context).unfocus();
                            },
                            color: Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
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
