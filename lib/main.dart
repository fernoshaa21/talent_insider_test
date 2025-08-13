import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:template_clean_architecture_june_2025/config.dart';
import 'package:template_clean_architecture_june_2025/di/di.dart';

import 'app.dart';

import 'dart:async';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

@pragma('vm:entry-point')
Future<void> _initializeApp() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    late final String appSupportPath;

    if (kIsWeb) {
      HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: HydratedStorageDirectory.web,
      );
      appSupportPath = 'web';
    } else {
      final dir = await getApplicationSupportDirectory();
      appSupportPath = dir.path;

      HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: HydratedStorageDirectory(appSupportPath),
      );
    }

    final packageInfo = await PackageInfo.fromPlatform();
    final deviceInfo = await DeviceInfoPlugin().deviceInfo;

    await setupInjection();
    await di.allReady();

    AppConfig.init('fcmToken', appSupportPath, packageInfo, deviceInfo);

    print('App initialization completed');
  } catch (e, stack) {
    print('Error in _initializeApp: $e');
    print('Stack trace: $stack');
    rethrow;
  }
}

void main() async {
  try {
    await _initializeApp();
    HttpOverrides.global = MyHttpOverrides();
    runApp(const App());
  } catch (e, stack) {
    print('Fatal error during initialization: $e');
    print('Stack trace: $stack');
  }
}
