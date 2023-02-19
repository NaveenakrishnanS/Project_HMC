import 'package:flutter/material.dart';
import 'package:floating_action_bubble_custom/floating_action_bubble_custom.dart';
import 'package:project_hmc/screens/Login_screen.dart';
import 'package:anim_search_bar/anim_search_bar.dart';

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
                leadingWidth: 60,
                elevation: 0,
                backgroundColor: Colors.black,
                leading: const Align(
                  alignment: Alignment.center,
                  child: Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Icon(Icons.chat_bubble_outline_rounded,
                    size: 30,
                  ),
                ),
                ),


                title:const Align(
                  alignment: Alignment.centerLeft,
                  child:Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text('Chats',
                    style: TextStyle(
                        fontSize: 25
                      ),
                    ),
                  ),
                ),

              actions:  [
                Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: AnimSearchBar(
                    style: const TextStyle(
                        color: Colors.white
                    ),
                    prefixIcon: Icon(Icons.search,
                    size: 30,
                    ),
                    suffixIcon: Icon(Icons.close,
                    size: 20,
                    ),
                    rtl: true,color: Colors.black,
                    textFieldIconColor: Colors.white,
                    textFieldColor: Colors.black,
                    boxShadow: false,
                    searchIconColor: Colors.white,
                    width: 400,
                    textController: textController,
                    onSuffixTap: () {
                      setState(() {
                        textController.clear();
                      });
                    }, onSubmitted:(String) {},
                  ),
                ),

              ],
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const LoginScreen(),
                      ),
                    );
                    _animationController.reverse();
                  },
                ),
              ],
            ),
          ),
      );
    }
}













class Search extends SearchDelegate{
  List<String> allData = [
    'india','russia','america','Japan'
  ];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return[
      IconButton(
          onPressed: (){
            query = '';
          },
          icon: const Icon(Icons.clear)
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
        return IconButton(
            onPressed: (){
              close(context, null);
        },
            icon: const Icon(Icons.arrow_back)
        );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for(var item in allData){
      if(item.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(item);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for(var item in allData){
      if(item.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(item);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        }
    );
  }

}