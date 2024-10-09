import 'package:ecommerce/consts/db_collections.dart';
import 'package:ecommerce/controller/auth_controller.dart';
import 'package:ecommerce/controller/task_controller.dart';
import 'package:ecommerce/firebase_options.dart';
import 'package:ecommerce/views/Splash_screen.dart';
import 'package:ecommerce/views/home_screen.dart';
import 'package:ecommerce/views/sign_in_screen.dart';
import 'package:ecommerce/views/signupscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

enum Routes { splash, signin, signnup, homescreen }

final navigatorKey = GlobalKey<NavigatorState>();
BuildContext get appContext => navigatorKey.currentState!.context;

Logger logger = Logger();
DbCollections dbCollections = DbCollections();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Ecommerce());
}

class Ecommerce extends StatelessWidget {
  Ecommerce({super.key});

  GoRouter router = GoRouter(navigatorKey: navigatorKey, routes: [
    GoRoute(
      path: '/',
      name: Routes.splash.name,
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
        path: "/signin",
        name: Routes.signin.name,
        builder: (context, state) => SignInScreen(),
        routes: [
          GoRoute(
            path: "signup",
            name: Routes.signnup.name,
            builder: (context, state) => SignUpScreen(),
          )
        ]),
    GoRoute(
      path: "/home",
      name: Routes.homescreen.name,
      builder: (context, state) => HomeScreen(),
    )
  ]);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(430, 932),
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthController()),
            ChangeNotifierProvider(create: (_) => TaskController())
          ],
          child: MaterialApp.router(
            routerConfig: router,
            debugShowCheckedModeBanner: false,
          ),
        ));
  }
}
