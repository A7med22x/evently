import 'package:evently/nav_bar_icon.dart';
import 'package:evently/tabs/favorite/favorite_tab.dart';
import 'package:evently/tabs/home/home_tab.dart';
import 'package:evently/tabs/profile/profile_tab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> tabs = [HomeTab(), FavoriteTab(), ProfileTab()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          currentIndex = index;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: NavBarIcon(iconName: 'home'),
            activeIcon: NavBarIcon(iconName: 'home_active'),
          ),
          BottomNavigationBarItem(
            label: 'Favorite',
            icon: NavBarIcon(iconName: 'favorite'),
            activeIcon: NavBarIcon(iconName: 'favorite_active'),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: NavBarIcon(iconName: 'profile'),
            activeIcon: NavBarIcon(iconName: 'profile_active'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add, size: 32),
      ),
    );
  }
}
