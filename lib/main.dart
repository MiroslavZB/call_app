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

late ObjectBox objectBox;

void main() async {
  // This is required so ObjectBox can get the application directory to store the database in.
  WidgetsFlutterBinding.ensureInitialized();

  // Create an instance of ObjectBox to use throughout the app.
  objectBox = await ObjectBox.create();
  await objectBox.addStartingContacts();
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: routerConfig,
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
