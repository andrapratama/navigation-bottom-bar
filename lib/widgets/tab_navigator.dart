import 'package:flutter/material.dart';
import 'package:navigationbottombar/widgets/tab_item.dart';

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
