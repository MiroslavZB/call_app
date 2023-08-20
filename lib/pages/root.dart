import 'package:call_app/functions/calling_bottom_sheet.dart';
import 'package:call_app/models/navigation_bar_tab_item.dart';
import 'package:call_app/resources/constants.dart';
import 'package:call_app/router/paths.dart';
import 'package:call_app/state/search_filters_state.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  late final TextEditingController searchController;
  late final TextEditingController callController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    callController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      bottomNavigationBar: sharedBottomBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: darkAccentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(bigBorderRadius),
        ),
        onPressed: () {
          callController.text = '';
          showNumbersField(context, callController);
        },
        child: const Icon(Icons.dialpad_outlined, size: regularIconSize),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            sharedTopBar(),
            Expanded(child: widget.child),
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
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(bigBorderRadius),
      ),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.search),
          ),
          Expanded(
            child: TextField(
              controller: searchController,
              onChanged: (String? value) {
                if (value == null) return;
                final filtersBloc = context.read<FiltersBloc>();

                if (value.isEmpty) return filtersBloc.clear();
                if (int.tryParse(value) == null && !value.startsWith('+')) return filtersBloc.setName(value);
                return filtersBloc.setPhone(value);
              },
              onSubmitted: (_) => FocusScope.of(context).unfocus(),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Search contacts & places',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
