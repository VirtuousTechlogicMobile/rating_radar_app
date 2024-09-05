import 'package:RatingRadar_app/constant/strings.dart';
import 'package:RatingRadar_app/initial_bindings/initial_bindings.dart';
import 'package:RatingRadar_app/services/translations/app_translations.dart';
import 'package:RatingRadar_app/theme/theme_controller.dart';
import 'package:RatingRadar_app/utility/utility.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'constant/hive_box_names.dart';
import 'routes/app_pages.dart';
import 'services/network/network_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDaiPmQawxczPefXWObn9npnFR31eylpFY",
          authDomain: "rating-reviews-app.firebaseapp.com",
          projectId: "rating-reviews-app",
          storageBucket: "rating-reviews-app.appspot.com",
          messagingSenderId: "662742740036",
          appId: "1:662742740036:web:e8f8a7b40602ac1daee011",
          measurementId: "G-56MTP8JR3J"),
    );
  } else {
    await Firebase.initializeApp();
  }
  await _initPreAppServices();
  final networkService = NetworkController.instance;
  await networkService.init();
  runApplication();
}

void runApplication() {
  AppUtility.log('Initializing App');
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
  AppUtility.log('App Initialized');
}

Future<void> _initPreAppServices() async {
  AppUtility.log('Initializing PreApp Services');
  await GetStorage.init();
  await Hive.initFlutter();

  AppUtility.log('Registering Hive Adapters');

  AppUtility.log('Hive Adapters Registered');

  AppUtility.log('Opening Hive Boxes');

  await Hive.openBox<String>(HiveBoxNames.themeMode);

  AppUtility.log('Hive Boxes Opened');

  AppUtility.log('Initializing Get Services');

  Get.put(AppThemeController(), permanent: true);

  AppUtility.log('Get Services Initialized');

  AppUtility.log('Checking Token');

  AppUtility.log('Token Checked');

  AppUtility.log('PreApp Services Initialized');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  String _handleAppInitialRoute() {
    return AppRoutes.adminSignIn;
  }

  ThemeMode _handleAppTheme(String mode) {
    if (mode == kDarkMode) {
      return ThemeMode.dark;
    }
    if (mode == kLightMode) {
      return ThemeMode.light;
    }
    return ThemeMode.system;
  }

  @override
  Widget build(BuildContext context) {
    final appController = Get.find<AppThemeController>();
    return ScreenUtilInit(
      designSize: const Size(392, 744),
      builder: (ctx, child) {
        return Obx(
          () {
            return GlobalLoaderOverlay(
              child: GetMaterialApp(
                initialBinding: InitialBindings(),
                title: StringValues.appName,
                debugShowCheckedModeBanner: false,
                themeMode: _handleAppTheme(appController.themeMode),
                theme: appController.getLightThemeData(context),
                darkTheme: appController.getDarkThemeData(context),
                getPages: AppPages.pages,
                initialRoute: _handleAppInitialRoute(),
                translations: AppTranslation(),
                locale: Get.deviceLocale,
                fallbackLocale: const Locale('en', 'IN'),
              ),
            );
          },
        );
      },
    );
  }
}
