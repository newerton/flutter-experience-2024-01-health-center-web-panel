import 'package:flutter/material.dart';
import 'package:flutter_experience_health_center_web_panel/src/modules/home/home_controller.dart';
import 'package:flutter_experience_health_center_web_panel/src/modules/home/home_route.dart';
import 'package:flutter_experience_health_center_web_panel/src/repositories/panel_checkin/panel_checkin_repository.dart';
import 'package:flutter_experience_health_center_web_panel/src/repositories/panel_checkin/panel_checkin_repository_impl.dart';
import 'package:flutter_getit/flutter_getit.dart';

class HomeModule extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<PanelCheckinRepository>(
            (i) => PanelCheckinRepositoryImpl(restCLient: i())),
        Bind.lazySingleton((i) => HomeController(repository: i()))
      ];

  @override
  String get moduleRouteName => '/home';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/': (_) => const HomeRouter(),
      };
}
