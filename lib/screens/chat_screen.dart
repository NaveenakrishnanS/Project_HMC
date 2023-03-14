import 'package:flutter/material.dart';
import 'package:floating_action_bubble_custom/floating_action_bubble_custom.dart';
import 'package:project_hmc/screens/register_screen.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with SingleTickerProviderStateMixin  {
  late Animation<double> _animation;
  late AnimationController _animationController;
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    final curvedAnimation = CurvedAnimation(
      curve: Curves.easeInOut,
      parent: _animationController,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        appBar:PreferredSize(
            preferredSize: const Size.fromHeight(65),
            child: AppBar(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                leadingWidth: 200,
                elevation: 0,
                backgroundColor: Colors.black,
                leading:  Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 20),
                  child: Row(
                    children: const [
                      Icon(Icons.messenger_outline,
                      size: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 28),
                        child: Text(
                          'Chats',
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

            actions: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(top: 12.5),
                      child: SearchBarAnimation(
                        enteredTextStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        ),
                        textEditingController: TextEditingController(),
                        buttonBorderColour: Colors.black,
                        buttonColour: Colors.black,
                        searchBoxColour: Colors.black,
                        cursorColour: Colors.white,
                        enableBoxBorder: false,
                        enableBoxShadow: false,
                        enableButtonBorder: false,
                        enableButtonShadow: false,
                        buttonElevation:0,
                        durationInMilliSeconds: 160,
                        isSearchBoxOnRightSide: true,
                        isOriginalAnimation: true,
                        enableKeyboardFocus: true,

                        onExpansionComplete: () {

                        },
                        trailingWidget: const Icon(
                          Icons.search,
                          size: 20,
                          color: Colors.white,
                        ),
                        secondaryButtonWidget: const Icon(
                          Icons.close,
                          size: 20,
                          color: Colors.white,
                        ),
                        buttonWidget: const Icon(
                          Icons.search,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                  ),
              ]
              )
            ),


          body:Column(
            children: const [

            ],
          ),











          floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: FloatingActionBubble(
                animation: _animation,
                onPressed: () => _animationController.isCompleted
                ? _animationController.reverse()
                : _animationController.forward(),
                  iconColor: Colors.white,
                  iconData: Icons.chat,
                  backgroundColor: Colors.black,
              items: <Widget>[
                // Floating action menu item
                BubbleMenu(
                  title: "Settings",
                  iconColor: Colors.white,
                  bubbleColor: Colors.black,
                  icon: Icons.settings,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                  onPressed: () {
                    _animationController.reverse();
                  },
                ),
                // Floating action menu item
                BubbleMenu(
                  title: "Profile",
                  iconColor: Colors.white,
                  bubbleColor: Colors.black,
                  icon: Icons.people,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const Register(phoneNumber: '+917200068446',),
                      ),
                    );
                    _animationController.reverse();
                  },
                ),
                //Floating action menu item
                BubbleMenu(
                  title: "Home",
                  iconColor: Colors.white,
                  bubbleColor: Colors.black,
                  icon: Icons.home,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                  onPressed: () {

                    _animationController.reverse();
                  },
                ),
              ],
            ),
          ),
      );
    }
}