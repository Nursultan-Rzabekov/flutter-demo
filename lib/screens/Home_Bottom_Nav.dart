import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'GHFlutterState.dart';
import 'MenuTabBarPage.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [HomeWidget(), MenuTabBarPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
              icon: new Icon(Icons.home), title: new Text("qwe")),
          BottomNavigationBarItem(
              icon: new Icon(Icons.mail), title: new Text("asdasd"))
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
