import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'controllers/constants.dart';
import 'controllers/session_controller.dart';
import 'controllers/session_manger.dart';
import 'models/state_model.dart';
import 'models/theme_model.dart';
import 'views/error_page.dart';
import 'views/performer/performer_bookings.dart';
import 'views/performer/performer_frame.dart';
import 'views/performer/performer_insights.dart';
import 'views/performer/performer_messages.dart';
import 'views/performer/performer_profile.dart';
import 'views/performer/performer_profile_edit.dart';
import 'views/signin.dart';
import 'views/signup.dart';
import 'widgets/custom_snackbar.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final sectionNavigatorKey = GlobalKey<NavigatorState>();
SessionController session = SessionController();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  setPathUrlStrategy();
  await dotenv.load(fileName: '.env');
  await GetStorage.init();
  runApp(MyApp());
}

final constantValues = Get.put(Constants());
var userInfo = GetStorage();

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

class ThemeProvider with ChangeNotifier {
  ThemeMode selectedThemeMode = ThemeMode.system;

  setSelectedThemeMode(bool comparator) {
    selectedThemeMode = comparator ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter router = GoRouter(
      navigatorKey: rootNavigatorKey,
      redirect: (BuildContext context, GoRouterState state) {
        if (userInfo.read("performerData").isEmpty) {
          return '/signin';
        } else {
          return null; // return "null" to display the intended route without redirecting
        }
      },
      debugLogDiagnostics: true,
      errorBuilder: (context, state) => const Error404(),
      initialLocation: '/',
      routes: [
        GoRoute(
          path: "/",
          redirect: (context, state) {
            return '/signin';
          },
        ),
        GoRoute(
          name: "signin",
          path: "/signin",
          pageBuilder: (context, state) =>
              NoTransitionPage(child: Signin(session: session)),
        ),
        GoRoute(
          name: "signup",
          path: "/signup",
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: Signup()),
        ),
        GoRoute(
          name: "performer",
          path: '/performer',
          builder: (context, state) => const PerformerFrame(),
          redirect: (context, state) {
            if (userInfo.read("performerData").isEmpty) {
              return '/signin';
            }
            return null; // return "null" to display the intended route without redirecting
          },
          routes: <RouteBase>[
            GoRoute(
              name: "performer_profile",
              path: 'profile',
              builder: (context, state) => const PerformerProfile(),
            ),
            GoRoute(
              name: "performer_profile_edit",
              path: 'edit-profile',
              builder: (context, state) => const PerformerProfileEdit(),
            ),
            GoRoute(
              name: "performer_insights",
              path: 'insights',
              builder: (context, state) => const PerformerInsights(),
            ),
            GoRoute(
              name: "performer_bookings",
              path: 'bookings',
              builder: (context, state) => const PerformerBookings(),
            ),
            GoRoute(
              name: "performer_messages",
              path: 'messages',
              builder: (context, state) => const PerformerMessages(),
            ),
          ],
        ),
        // StatefulShellRoute.indexedStack(
        //     builder: (context, state, navigationShell) {
        //       return PerformerFrame(navigationShell: navigationShell);
        //     },
        //     branches: [
        //       // The route branch for the 1º Tab
        //       StatefulShellBranch(
        //           // navigatorKey: _sectionNavigatorKey,
        //           // Add this branch routes
        //           // each routes with its sub routes if available e.g feed/uuid/details
        //           routes: <RouteBase>[
        //             GoRoute(
        //               name: "performer_profile",
        //               path: '/p/profile',
        //               builder: (context, state) => const PerformerProfile(),
        //             ),
        //           ]),
        //       StatefulShellBranch(routes: <RouteBase>[
        //         GoRoute(
        //           name: "performer_insights",
        //           path: '/p/insights',
        //           builder: (context, state) => const PerformerInsights(),
        //         ),
        //       ]),
        //       StatefulShellBranch(routes: <RouteBase>[
        //         GoRoute(
        //           name: "performer_bookings",
        //           path: '/p/bookings',
        //           builder: (context, state) => const PerformerBookings(),
        //         ),
        //       ]),
        //       StatefulShellBranch(routes: <RouteBase>[
        //         GoRoute(
        //           name: "performer_messages",
        //           path: '/p/messages',
        //           builder: (context, state) => const PerformerMessages(),
        //         ),
        //       ]),
      ]);
  // ]);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    userInfo.writeIfNull("isDarkTheme", true);
    userInfo.writeIfNull("isSignedIn", false);
    userInfo.writeIfNull("agreeToTerms", false);
    userInfo.writeIfNull("rememberMe", false);
    userInfo.writeIfNull("tempEmail", "");
    userInfo.writeIfNull("tempPassword", "");
    userInfo.writeIfNull("accountType", "");
    userInfo.writeIfNull("currentIndex", 0);
    userInfo.writeIfNull("performerData", {
      "fullName": "Johnny Doe",
      "stageName": "john d doe",
      "userName": "johnny_doe",
      "emailAddress": "johndoe@gmail.com",
      "accountType": "performer",
      "performerType": "",
      "completedRegistration": false,
    });
    final constantValues = Get.put(Constants());
    var color = constantValues.defaultColor;
    return ChangeNotifierProvider<ThemeChanger>(
      create: (_) => ThemeChanger(ThemeData(
        primarySwatch: MaterialColor(0xFF4CAF50, color),
        colorScheme: ColorScheme.fromSeed(
            brightness: userInfo.read("isDarkTheme")
                ? Brightness.dark
                : Brightness.light,
            seedColor: constantValues.primaryColor),
        useMaterial3: true,
        textTheme: GoogleFonts.archivoTextTheme(Theme.of(context).textTheme)
            .apply(
                bodyColor: userInfo.read("isDarkTheme")
                    ? constantValues.whiteColor
                    : constantValues.darkColor),
        brightness:
            userInfo.read("isDarkTheme") ? Brightness.dark : Brightness.light,
      )),
      child: MaterialAppWithTheme(
          context: context, router: router, constantValues: constantValues),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  MaterialAppWithTheme({
    super.key,
    required this.context,
    required GoRouter router,
    required this.constantValues,
  }) : _router = router;
  StreamController streamController = StreamController();
  BuildContext context;
  final GoRouter _router;
  final Constants constantValues;

  void redirectToSigninPage() {
    if (rootNavigatorKey.currentContext != null) {
      _router.goNamed("signin");
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    if (rootNavigatorKey.currentContext != null) {
      session.startListener(
          context: context, streamController: streamController);
    } else {
      session.stopListener(
          context: context, streamController: streamController);
    }
    return ChangeNotifierProvider(
        create: (context) => CustomStateModel(),
        child: SessionManager(
          onSessionExpired: () {
            if (rootNavigatorKey.currentContext != null &&
                session.enableSigninPage) {
              userInfo.write("performerData", {});
              ScaffoldMessenger.of(rootNavigatorKey.currentContext!)
                  .showSnackBar(sessionExpiry);
              redirectToSigninPage();
            }
          },
          duration: const Duration(hours: 12),
          streamController: streamController,
          child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              scrollBehavior: MyCustomScrollBehavior(),
              routerConfig: _router,
              title: "GiggBox",
              theme: theme.getTheme()
              // ThemeData(
              //     colorScheme: ColorScheme.fromSeed(
              //         seedColor: constantValues.secondaryColor),
              //     useMaterial3: true,
              //     textTheme:
              //         GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              //             .apply(bodyColor: constantValues.secondaryColor)
              //     // .copyWith(
              //     //   bodyLarge: TextStyle(color: constantValues.bodyTextColor),
              //     //   bodyMedium: TextStyle(color: constantValues.bodyTextColor)
              //     // )
              //     ),
              ),
        ));
  }
}
