import 'package:call_app/models/filters.dart';
import 'package:call_app/router/router_config.dart';
import 'package:call_app/services/database/objectbox.dart';
import 'package:call_app/state/search_filters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FavoriteBloc(initialState: false)),
        BlocProvider(create: (_) => FiltersBloc(filters: Filters.empty())),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        routerConfig: routerConfig,
      ),
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
