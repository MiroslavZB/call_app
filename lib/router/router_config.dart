import 'package:call_app/models/contact.dart';
import 'package:call_app/pages/contact_info_page.dart';
import 'package:call_app/pages/contacts_page.dart';
import 'package:call_app/pages/favorites_page.dart';
import 'package:call_app/pages/new_contact_page.dart';
import 'package:call_app/pages/recents_page.dart';
import 'package:call_app/pages/root.dart';
import 'package:call_app/router/paths.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final routerConfig = GoRouter(
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
            phone: state.queryParams['phone'],
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
          ),
        );
      },
    ),
  ],
);
