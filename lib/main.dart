import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:vitec_travels/routes/router.dart';
import 'package:vitec_travels/routes/routes.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'data/core/config.dart';
import 'locator.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  //===========================================================//

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  setupLocator();
  Config.appFlavor = Flavor.DEVELOPMENT;
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Vitec Travels',
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            appBarTheme: AppBarTheme(
                color: Colors.white
            )
        ),
        initialRoute: HomeScreens,
        onGenerateRoute: Routers.generateRoute,
      ),
    );
  }
}
