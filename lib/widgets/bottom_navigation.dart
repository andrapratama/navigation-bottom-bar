import 'package:flutter/material.dart';
import 'package:navigationbottombar/widgets/tab_item.dart';

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
