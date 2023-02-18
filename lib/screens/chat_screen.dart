import 'package:flutter/material.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        appBar:PreferredSize(
            preferredSize: const Size.fromHeight(70),
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

              actions: [
                Align(
                  alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: IconButton(onPressed: (){
                    showSearch(
                        context: context,
                        delegate: Search()
                    );
                  },
                      icon: const Icon(Icons.search,
                        size: 30,
                      )
                  ),
                 )
                )
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
            child: FloatingActionButton(
                onPressed: (){

                },
                backgroundColor: Colors.black,
                child: const Icon(Icons.chat),
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