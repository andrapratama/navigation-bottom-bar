import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static const routeName = '/dashboard_page_screen';

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

enum TabItem { home, search, profile }

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  TabNavigator(
      {Key? key,
      required this.navigatorKey,
      required this.tabItem,
      required this.widget})
      : super(key: key);
  final GlobalKey<NavigatorState>? navigatorKey;
  final TabItem tabItem;
  final Widget widget;

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {TabNavigatorRoutes.root: (context) => widget};
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name!]!(context),
        );
      },
    );
  }
}

class BottomNavigation extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const BottomNavigation({required this.currentTab, required this.onSelectTab});

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ClipRRect(
        // ignore: prefer_const_constructors
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(40.0),
          topRight: const Radius.circular(40.0),
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedFontSize: 0,
          type: BottomNavigationBarType.fixed,
          items: _bottomNavBarItems,
          onTap: (index) => onSelectTab(
            TabItem.values[index],
          ),
          currentIndex: currentTab.index,
          selectedItemColor: activeTabColor[currentTab]!,
        ),
      ),
    );
  }
}

List<BottomNavigationBarItem> _bottomNavBarItems = [
  const BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: '',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.search),
    label: '',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.person),
    label: '',
  ),
];

const Map<TabItem, Color> activeTabColor = {
  TabItem.home: Colors.blue,
  TabItem.search: Colors.blue,
  TabItem.profile: Colors.blue,
};

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 223, 232, 239),
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}

class SearchSrceen extends StatelessWidget {
  const SearchSrceen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 223, 232, 239),
      body: Center(
        child: Text('Search'),
      ),
    );
  }
}

class ProfileSrceen extends StatelessWidget {
  const ProfileSrceen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 223, 232, 239),
      body: Center(
        child: Text('Profile'),
      ),
    );
  }
}
