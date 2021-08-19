// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

// Project imports:
import 'package:blogapp/views/follows.dart';
import 'package:blogapp/views/home.dart';
import 'package:blogapp/views/profile.dart';
import 'package:blogapp/views/search.dart';

class MainScreenView extends StatefulWidget {
  @override
  _MainScreenViewState createState() => _MainScreenViewState();
}

class _MainScreenViewState extends State<MainScreenView> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (pageIndex) {
            setState(() {
              _selectedIndex = pageIndex;
            });
          },
          children: [
            HomeView(),
            SearchView(),
            FollowsView(),
            ProfileView(),
          ],
        ),
        bottomNavigationBar: SizedBox(
          height: 70,
          child: BottomNavyBar(
            iconSize: 33,
            selectedIndex: _selectedIndex,
            backgroundColor: Colors.black,
            showElevation: true, // use this to remove appBar's elevation
            onItemSelected: (index) => setState(() {
              _selectedIndex = index;
              _pageController.animateToPage(index,
                  duration: Duration(milliseconds: 300), curve: Curves.ease);
            }),
            items: [
              BottomNavyBarItem(
                icon: Icon(Icons.home_outlined),
                title: Text('Home'),
                activeColor: Colors.red,
              ),
              BottomNavyBarItem(
                  icon: Icon(Icons.search_outlined),
                  title: Text('Search'),
                  activeColor: Colors.purpleAccent),
              BottomNavyBarItem(
                  icon: Icon(Icons.favorite_border_outlined),
                  title: Text('Follows'),
                  activeColor: Colors.pink),
              BottomNavyBarItem(
                  icon: Icon(Icons.account_circle_outlined),
                  title: Text('Profile'),
                  activeColor: Colors.blue),
            ],
          ),
        ));
  }
}
