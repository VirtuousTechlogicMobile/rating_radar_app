import 'package:RatingRadar_app/constant/strings.dart';
import 'package:RatingRadar_app/services/translations/app_translations.dart';
import 'package:RatingRadar_app/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:RatingRadar_app/utility/utility.dart';
import 'package:flutter/services.dart';

import 'constant/hive_box_names.dart';
import 'routes/app_pages.dart';
import 'services/network/network_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    return AppRoutes.welcome;
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
        return GetMaterialApp(
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
        );
      },
    );
  }
}
