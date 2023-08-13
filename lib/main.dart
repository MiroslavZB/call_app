import 'package:call_app/models/contact.dart';
import 'package:call_app/pages/new_contact_page.dart';
import 'package:call_app/pages/root.dart';
import 'package:call_app/pages/contacts_page.dart';
import 'package:call_app/pages/favorites_page.dart';
import 'package:call_app/pages/recents_page.dart';
import 'package:call_app/resources/paths.dart';
import 'package:call_app/services/database/objectbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import 'pages/contact_info_page.dart';

late ObjectBox objectbox;

void main() async {
  // This is required so ObjectBox can get the application directory to store the database in.
  WidgetsFlutterBinding.ensureInitialized();

  // Create an instance of ObjectBox to use throughout the app.
  objectbox = await ObjectBox.create();
  await objectbox.addStartingContacts();
  runApp(const MyApp());

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top],
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
}

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final _router = GoRouter(
  initialLocation: Paths.recents,
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (_, __, child) {
        return RootPage(child: child);
      },
      routes: [
        GoRoute(
          path: Paths.favorites,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: FavoritesPage(),
          ),
        ),
        GoRoute(
          path: Paths.recents,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: RecentsPage(),
          ),
        ),
        GoRoute(
          path: Paths.contacts,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ContactsPage(),
          ),
        ),
      ],
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: Paths.newContact,
      name: Paths.newContact,
      pageBuilder: (context, state) {
        return NoTransitionPage(
          child: NewContactPage(
            contact: state.extra as Contact?,
            fromRecents: state.queryParams['fromRecents'],
            phone: state.queryParams['phone'],
            id: state.queryParams['id'],
          ),
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: Paths.contactInfo,
      name: Paths.contactInfo,
      pageBuilder: (context, state) {
        return NoTransitionPage(
          child: ContactInfoPage(
            contact: state.extra as Contact?,
            phone: state.queryParams['phone'],
            fromRecents: state.queryParams['fromRecents'],
            id: state.queryParams['id'],
          ),
        );
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _router,
    );
  }
}

/// Used to ensure context is still active before displaying the messenger.
extension BuildContextMounted on BuildContext {
  bool get mounted {
    try {
      (this as Element).widget;
      return true;
      // Widget get widget => _widget! inside Element will throw if it's not mounted anymore
    } on TypeError catch (_) {
      return false;
    }
  }
}
