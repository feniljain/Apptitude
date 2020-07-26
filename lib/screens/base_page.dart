import 'package:flutter/material.dart';

import 'task_page.dart';
import 'records_page.dart';
import 'settings_page.dart';

class ScreenWithIndex {
  final Widget screen;
  final int index;

  ScreenWithIndex({this.screen, this.index});
}

class BasePage extends StatefulWidget {
  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage>
    with TickerProviderStateMixin<BasePage> {

  int _currentIndex = 1;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
    List<Widget> _widgetOptions = <Widget>[
    RecordsPage(),
    TaskPage(),
    SettingsPage(),
  ];

  @override
  void initState() {
    _currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_currentIndex],
      //body: SafeArea(
      //  child: Stack(
      //    fit: StackFit.expand,
      //    children: children
      //        .call()
      //        .map((ScreenWithIndex screen) {
      //          final Widget view = FadeTransition(
      //            opacity: _faders[screen.index]
      //                .drive(CurveTween(curve: Curves.fastOutSlowIn)),
      //            child: KeyedSubtree(
      //                key: _destinationKeys[screen.index],
      //                child: children.call()[screen.index].screen),
      //          );
      //          if (screen.index == _currentIndex) {
      //            _faders[screen.index].forward();
      //            return view;
      //          } else {
      //            _faders[screen.index].reverse();
      //            if (_faders[screen.index].isAnimating) {
      //              return IgnorePointer(child: view);
      //            }
      //            return Offstage(child: view);
      //          }
      //        })
      //        .cast<Widget>()
      //        .toList(),
      //  ),
      //),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.apps,
            ),
            title: Text('Record'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu,
            ),
            title: Text('Tasks'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            title: Text('Settings'),
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Color(0xFFFA6400),
        unselectedItemColor: Color(0xFFFA6400),
        onTap: onTabTapped,
      ),
    );
  }
  //PageView(
  //  controller: _currPageIndex,
  //  onPageChanged: (_) {},
  //  children: [],
  //),
}
