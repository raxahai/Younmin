import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseManager {
  static void initializeAnalytics() {
    FirebaseAnalytics();
  }

  static FirebaseAnalytics getAnalytics() {
    return FirebaseAnalytics();
  }

  static Future<void> setCurrentScreen(String screenName) async {
    FirebaseAnalytics().setCurrentScreen(screenName: screenName);
  }

  static Future<void> setCurrentUser(String userName) async {
    FirebaseAnalytics().setUserId(userName);
  }

  static Future<void> sendCustomEvent(String name,
      {Map<String, dynamic> parameters = const {}}) async {
    FirebaseAnalytics analytics = FirebaseAnalytics();
    await analytics.logEvent(
      name: name,
      parameters: parameters,
    );
  }
}
