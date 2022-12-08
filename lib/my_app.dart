import 'package:flutter/material.dart';
import 'package:navigationbottombar/screens/home_screen.dart';
import 'package:navigationbottombar/screens/profile_screen.dart';
import 'package:navigationbottombar/screens/search_screen.dart';
import 'package:navigationbottombar/widgets/bottom_navigation.dart';
import 'package:navigationbottombar/widgets/tab_item.dart';
import 'package:navigationbottombar/widgets/tab_navigator.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  var _currentTab = TabItem.home;
  final _navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.search: GlobalKey<NavigatorState>(),
    TabItem.profile: GlobalKey<NavigatorState>()
  };

  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WillPopScope(
        onWillPop: () async {
          final isFirstRouteInCurrentTab =
              !await _navigatorKeys[_currentTab]!.currentState!.maybePop();
          if (isFirstRouteInCurrentTab) {
            // if not on the 'main' tab
            if (_currentTab != TabItem.home) {
              // select 'main' tab
              _selectTab(TabItem.home);
              // back button handled by app
              return false;
            }
          }
          // let system handle back button if we're on the first route
          return isFirstRouteInCurrentTab;
        },
        child: Scaffold(
          body: Stack(children: <Widget>[
            _buildOffstageNavigator(TabItem.home, const HomeScreen()),
            _buildOffstageNavigator(TabItem.search, const SearchSrceen()),
            _buildOffstageNavigator(TabItem.profile, const ProfileSrceen()),
          ]),
          bottomNavigationBar: BottomNavigation(
            currentTab: _currentTab,
            onSelectTab: _selectTab,
          ),
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem, Widget widget) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
          navigatorKey: _navigatorKeys[tabItem],
          tabItem: tabItem,
          widget: widget),
    );
  }
}
