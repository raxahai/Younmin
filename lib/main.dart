import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/app_theme.dart';
import 'logic/login/login_cubit.dart';
import 'router/router.gr.dart';

// set this const into true if we want to use firebase emulator for testing
// before use the emulator should be up and running on the specified ports

// ignore: constant_identifier_names
const USE_FIREBASE_EMULATOR = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // check if is running on Web
  if (kIsWeb) {
    // initialiaze the facebook javascript SDK
    FacebookAuth.i.webInitialize(
      // testing app for now
      // use the production id when publishing {250440266907457}

      appId: "250440266907457",
      cookie: true,
      xfbml: true,
      version: "v1.0",
    );
  }
  if (USE_FIREBASE_EMULATOR) {
    FirebaseFirestore.instance.useFirestoreEmulator("localhost", 8080);
    FirebaseAuth.instance.useAuthEmulator("127.0.0.1", 9099);
    FirebaseStorage.instance.useStorageEmulator("127.0.0.1", 9199);
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _router = YounminRouter();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return BlocProvider<LoginCubit>(
        create: (BuildContext context) => LoginCubit(),
        child: MaterialApp.router(
          builder: (context, widget) => ResponsiveWrapper.builder(
            BouncingScrollWrapper.builder(context, widget!),
            maxWidth: 1800,
            minWidth: 450,
            defaultScale: true,
            breakpoints: [
              const ResponsiveBreakpoint.resize(450, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(800, name: TABLET),
              const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
              const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
              const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
            ],
          ),
          title: "Younmin",
          theme: AppTheme.getTheme(),
          routerDelegate: _router.delegate(),
          routeInformationParser: _router.defaultRouteParser(),
        ),
      );
    });
  }
}
