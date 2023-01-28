import 'package:call_app/resources/paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  // getter that computes the current index from the current location,
  // using the helper method below
  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);

  int _locationToTabIndex(String location) {
    final index = tabs(0).indexWhere((t) => location.startsWith(t.initialLocation));
    // if index not found (-1), return 0
    return index < 0 ? 0 : index;
  }

  // callback used to navigate to the desired tab
  void _onItemTapped(BuildContext context, int tabIndex) {
    if (tabIndex != _currentIndex) {
      // go to the initial location of the selected tab (by index)
      context.go(tabs(_currentIndex)[tabIndex].initialLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: tabs(_currentIndex),
        onTap: (index) => _onItemTapped(context, index),
        selectedItemColor: Colors.black,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            topSharedBar(),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height - 80 - 50,
              ),
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }

  Widget topSharedBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
        height: 50,
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(25),
        ),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: const [
            Icon(Icons.search),
            Expanded(
              child: TextField(
                decoration: InputDecoration.collapsed(
                  hintText: 'Search contacts & places',
                ),
              ),
            ),
            Icon(Icons.keyboard_voice_outlined),
            Icon(Icons.more_vert_outlined)
          ],
        ),
      ),
    );
  }

  List<ScaffoldWithNavBarTabItem> tabs(int i) => [
        ScaffoldWithNavBarTabItem(
          initialLocation: Paths.favorites,
          icon: i == 0 ? const Icon(Icons.star) : const Icon(Icons.star_border),
          label: 'Favorites',
        ),
        ScaffoldWithNavBarTabItem(
          initialLocation: Paths.recents,
          icon: i == 1 ? const Icon(Icons.access_time_filled_rounded) : const Icon(Icons.access_time_rounded),
          label: 'Recents',
        ),
        ScaffoldWithNavBarTabItem(
          initialLocation: Paths.contacts,
          icon: i == 2 ? const Icon(Icons.people_alt) : const Icon(Icons.people_alt_outlined),
          label: 'Contacts',
        ),
      ];
}

class ScaffoldWithNavBarTabItem extends BottomNavigationBarItem {
  const ScaffoldWithNavBarTabItem({
    required this.initialLocation,
    required Widget icon,
    String? label,
  }) : super(icon: icon, label: label);

  /// The initial location/path
  final String initialLocation;
}
