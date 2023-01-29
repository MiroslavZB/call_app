import 'package:call_app/models/navigation_bar_tab_item.dart';
import 'package:call_app/resources/constants.dart';
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
  List<NavigationBarTabItem> tabs(int i) => [
        NavigationBarTabItem(
          initialLocation: Paths.favorites,
          icon: i == 0 ? const Icon(Icons.star) : const Icon(Icons.star_border),
          label: 'Favorites',
        ),
        NavigationBarTabItem(
          initialLocation: Paths.recents,
          icon: i == 1 ? const Icon(Icons.access_time_filled_rounded) : const Icon(Icons.access_time_rounded),
          label: 'Recents',
        ),
        NavigationBarTabItem(
          initialLocation: Paths.contacts,
          icon: i == 2 ? const Icon(Icons.people_alt) : const Icon(Icons.people_alt_outlined),
          label: 'Contacts',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      bottomNavigationBar: sharedBottomBar(),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            sharedTopBar(),
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

  // getter that computes the current index from the current location
  int get _currentIndex {
    final index = tabs(0).indexWhere(
      (e) => GoRouter.of(context).location.startsWith(e.initialLocation),
    );
    return index < 0 ? 0 : index;
  }

  Widget sharedBottomBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      items: tabs(_currentIndex),
      onTap: (index) {
        if (index != _currentIndex) {
          context.go(tabs(_currentIndex)[index].initialLocation);
        }
      },
      selectedItemColor: Colors.black,
      selectedFontSize: sizeH6,
      unselectedFontSize: sizeH6,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget sharedTopBar() {
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
              child: Text('Search contacts & places'),
            ),
            Icon(Icons.keyboard_voice_outlined),
            Icon(Icons.more_vert_outlined),
          ],
        ),
      ),
    );
  }
}
