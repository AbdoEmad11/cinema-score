import 'package:flutter/material.dart';
import '../screens/Search_screen.dart';
import '../screens/home_screen.dart';
import '../screens/new&hot.dart';
import '../screens/Profile_Screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: const Color(0xFF23272E),
          height: 70,
          child: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: "Home",
              ),
              Tab(
                icon: Icon(Icons.search),
                text: "Search",
              ),
              Tab(
                icon: Icon(Icons.article),
                text: "News",
              ),

              Tab(
                icon: Icon(Icons.person),
                text: "Profile",
              ),
            ],
            unselectedLabelColor: Color(0xFF999999),
            labelColor: Colors.blue,
            indicatorColor: Colors.transparent,
          ),
        ),
        body: TabBarView(
          children: [
            const HomeScreen(),
            const Search(),
            const MoreScreen(),
            ProfilePage(name: 'John Doe', email: 'johndoe@example.com'),
            // Add other screens here
          ],
        ),
      ),
    );
  }
}
