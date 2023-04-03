import 'package:flutter/material.dart';
import 'package:project_hmc/screens/Friend_list/friend_list.dart';
import 'package:project_hmc/screens/chat_screen/chat_screen.dart';
import 'package:project_hmc/screens/profile_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with AutomaticKeepAliveClientMixin<NavigationScreen> {
  final PageController controller = PageController();
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const ChatScreen(),
    const FriendList(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups),
            label: 'Friend List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            controller.jumpToPage(index);
            setState(() {
              _selectedIndex = index;
            });
          });
        },
      ),

      body: PageView(
        controller: controller,
        children: _screens,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
