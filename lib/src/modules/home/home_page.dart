import 'package:flutter/material.dart';
import 'package:flutter_experience_health_center_web_panel/src/models/panel_checkin_model.dart';
import 'package:flutter_experience_health_center_web_panel/src/modules/home/home_controller.dart';
import 'package:flutter_experience_health_center_web_panel/src/modules/home/widgets/home_password_tile_widget.dart';
import 'package:flutter_experience_health_center_web_panel/src/modules/home/widgets/home_principal_widget.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:health_center_core/health_center_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with MessagesViewMixin {
  final controller = Injector.get<HomeController>();

  @override
  void initState() {
    messageListener(controller);
    controller.listenerPanelCheckin();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    final PanelCheckinModel? current;
    final PanelCheckinModel? lastCall;
    final List<PanelCheckinModel>? others;

    final listPanel = controller.panelData.watch(context);

    current = listPanel.firstOrNull;
    if (listPanel.isNotEmpty) {
      listPanel.removeAt(0);
    }

    lastCall = listPanel.firstOrNull;
    if (listPanel.isNotEmpty) {
      listPanel.removeAt(0);
    }

    others = listPanel;

    return Scaffold(
      appBar: HealthCenterAppBar(
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(
            child: const IconPopupMenuWidget(),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Start Terminal'),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text('Logout'),
              )
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                lastCall != null
                    ? SizedBox(
                        width: sizeOf.width * 0.4,
                        child: HomePrincipalWidget(
                            passwordLabel: 'Previous password',
                            password: lastCall.password,
                            deskNumber: lastCall.attendantDesk
                                .toString()
                                .padLeft(2, '0'),
                            labelColor: HealthCenterTheme.blueColor,
                            buttonColor: HealthCenterTheme.orangeColor),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(width: 28),
                current != null
                    ? SizedBox(
                        width: sizeOf.width * 0.4,
                        child: HomePrincipalWidget(
                            passwordLabel: 'Calling password',
                            password: current.password,
                            deskNumber: current.attendantDesk
                                .toString()
                                .padLeft(2, '0'),
                            labelColor: HealthCenterTheme.orangeColor,
                            buttonColor: HealthCenterTheme.blueColor),
                      )
                    : const SizedBox.shrink()
              ],
            ),
            const Divider(color: HealthCenterTheme.orangeColor),
            const SizedBox(height: 24),
            Text('Latest calls',
                style: HealthCenterTheme.titleSmallStyle.copyWith(
                    color: HealthCenterTheme.orangeColor,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            Wrap(
              runAlignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: others
                  .map((e) => HomePasswordTileWidget(
                        password: e.password,
                        ticketOffice: e.attendantDesk.toString(),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
