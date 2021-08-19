// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

// Project imports:
import 'package:blogapp/controllers/authController.dart';
import 'package:blogapp/controllers/categoryController.dart';
import 'package:blogapp/controllers/followController.dart';
import 'package:blogapp/controllers/postController.dart';
import 'package:blogapp/services/local_notification_service.dart';
import 'package:blogapp/utils/root.dart';
import 'package:blogapp/views/add_post.dart';
import 'package:blogapp/views/home.dart';
import 'package:blogapp/views/login.dart';
import 'package:blogapp/views/post_detail.dart';
import 'package:blogapp/views/signup.dart';
import 'package:blogapp/views/splash.dart';
import 'controllers/userController.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  if (message.notification != null) {
    // LocalNotificationService.display(message);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotificationService.initialize();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(MyApp());
}

void initControllers() {
  Get.put(AuthController());
  Get.put(UserController());
  Get.put(FollowController());
  Get.put(PostController());
  Get.put(CategoryController());

  // Get.lazyPut(() => UserController());
  // Get.lazyPut(() => AuthController());
  // Get.lazyPut(() => FollowController());
  // Get.lazyPut(() => PostController());
  // Get.lazyPut(() => CategoryController());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initControllers();
    print(1);

    // from terminated
    // FirebaseMessaging.instance.getInitialMessage().then((message) {
    //   if (message != null && message.notification != null) {
    //     LocalNotificationService.display(message);
    //   }
    // });

    /// For foreground notification
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        LocalNotificationService.display(message);
      }
    });

    /// For background and not terminated and clicked
    // FirebaseMessaging.onMessageOpenedApp.listen((message) {
    //   if (message.notification != null) {
    //     LocalNotificationService.display(message);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('tr-TR');
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: true,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/home', page: () => HomeView()),
        GetPage(name: '/add-post', page: () => AddPostView()),
        GetPage(name: '/login', page: () => LoginView()),
        GetPage(name: '/signup', page: () => SignUpView()),
        GetPage(name: '/post-detail', page: () => PostDetailView()),
        GetPage(name: '/splash', page: () => SplashView()),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'SF Compact Rounded',
      ),
      home: SafeArea(child: Root()),
    );
  }
}
