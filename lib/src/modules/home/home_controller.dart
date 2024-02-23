import 'package:flutter_experience_health_center_web_panel/src/models/panel_checkin_model.dart';
import 'package:flutter_experience_health_center_web_panel/src/repositories/panel_checkin/panel_checkin_repository.dart';
import 'package:health_center_core/health_center_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

class HomeController with MessageStateMixin {
  HomeController({required PanelCheckinRepository repository})
      : _repository = repository;

  final PanelCheckinRepository _repository;
  final panelData = listSignal<PanelCheckinModel>([]);

  Connect? _panelConnect;
  Function? _socketDispose;

  void listenerPanelCheckin() {
    final (:channel, :dispose) = _repository.openChannelSocket();
    _socketDispose = dispose;
    _panelConnect = connect(panelData);

    final panelStream = _repository.getTodayPanelCheckin(channel);
    _panelConnect!.from(panelStream);
  }

  void dispose() {
    _panelConnect?.dispose();
    if (_socketDispose != null) {
      _socketDispose!();
    }
  }
}
