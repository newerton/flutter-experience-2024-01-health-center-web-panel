import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_experience_health_center_web_panel/src/binding/health_center_application_binding.dart';
import 'package:flutter_experience_health_center_web_panel/src/modules/auth/auth_module.dart';
import 'package:flutter_experience_health_center_web_panel/src/modules/home/home_module.dart';
import 'package:flutter_experience_health_center_web_panel/src/pages/splash_screen/page.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:health_center_core/health_center_core.dart';

void main() {
  runZonedGuarded(() async {
    runApp(const HealthCenterWebPanelApp());
  }, (error, stackTrace) {
    log('runZonedGuardedError', error: error, stackTrace: stackTrace);
    throw error;
  });
}

class HealthCenterWebPanelApp extends StatelessWidget {
  const HealthCenterWebPanelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return HealthCenterAppCore(
      title: 'Health Center',
      bindings: HealthCenterApplicationBinding(),
      pagesBuilders: [
        FlutterGetItPageBuilder(page: (_) => const SplashPage(), path: '/')
      ],
      modules: [
        AuthModule(),
        HomeModule(),
      ],
    );
  }
}
