import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';

class SingleChat extends StatefulWidget {
  const SingleChat({Key? key}) : super(key: key);

  @override
  State<SingleChat> createState() => _SingleChatState();
}

class _SingleChatState extends State<SingleChat> {
  final TextEditingController _controller = TextEditingController();
  bool emojiShowing = false;
  FocusNode focusNode = FocusNode();
  @override
  void initState()
  {
    super.initState();
    focusNode.addListener(() {
      if(focusNode.hasFocus){
        setState(() {
          emojiShowing = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: Row(
            children: [
              const CircleAvatar(),
              const SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "User",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
      body:SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
       child: WillPopScope(
         child: Stack(
          children: [
            ListView(),
            Align(
            alignment: Alignment.bottomCenter ,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    focusNode: focusNode,
                 controller: _controller,
                 style:  const TextStyle(
                  fontSize: 20.0, color: Colors.black87),
                  decoration: InputDecoration(
                  hintText: 'Type a message',
                  prefixIcon:IconButton(splashRadius:23,
                  icon:const Icon(Icons.emoji_emotions_rounded),
                  onPressed:(){
                    focusNode.unfocus();
                    focusNode.canRequestFocus = false;
                    setState(() {emojiShowing = !emojiShowing;});},
                ),
                suffixIcon:IconButton(splashRadius:5,
                  icon: const Icon(Icons.attach_file_rounded),color: Colors.grey,
                  onPressed:(){},
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.only(left: 16.0, bottom: 8.0, top: 8.0, right: 16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
          ),
                ),
                Material(
                  color: Colors.white,
                  child: IconButton(
                      splashRadius: 25,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.send,
                        color: Colors.black,
                      ),
                  iconSize: 40,),
                )
              ],
            )),
            Offstage(
              offstage: !emojiShowing,
              child: Align(
                alignment: Alignment.bottomCenter,
                child:SingleChildScrollView(
                 physics: const BouncingScrollPhysics(),
                 child:SizedBox(
                  height: 250,
                  child: EmojiPicker(
                    textEditingController: _controller,

                    config: Config(
                      columns: 7,
                      emojiSizeMax: 32 * (foundation.defaultTargetPlatform == TargetPlatform.iOS ? 1.30 : 1.0),
                      verticalSpacing: 0,
                      horizontalSpacing: 0,
                      gridPadding: EdgeInsets.zero,
                      initCategory: Category.RECENT,
                      bgColor: const Color(0xFFF2F2F2),
                      indicatorColor: Colors.blue,
                      iconColor: Colors.grey,
                      iconColorSelected: Colors.blue,
                      backspaceColor: Colors.blue,
                      skinToneDialogBgColor: Colors.white,
                      skinToneIndicatorColor: Colors.grey,
                      enableSkinTones: true,
                      showRecentsTab: true,
                      recentsLimit: 28,
                      replaceEmojiOnLimitExceed: false,
                      noRecents: const Text(
                        'No Recents',
                        style: TextStyle(fontSize: 20, color: Colors.black26),
                        textAlign: TextAlign.center,
                      ),
                      loadingIndicator: const SizedBox.shrink(),
                      tabIndicatorAnimDuration: kTabScrollDuration,
                      categoryIcons: const CategoryIcons(),
                      buttonMode: ButtonMode.CUPERTINO,
                      checkPlatformCompatibility: true,
                    ),
                  )),
            ),
            ),
            ),
          ],
         ),
         onWillPop:() {
           if(emojiShowing) {
             setState(() {
               emojiShowing = false;
             });
           }
           else
           {
             Navigator.pop(context);
           }
           return Future.value(false);
         },
       ),
        ),

      ),
    );
  }
}