import 'package:nitp_social/enum/view_state.dart';
import 'package:nitp_social/provider/getit.dart';
import 'package:nitp_social/services/navigation_service.dart';
import 'package:flutter/material.dart';

class BaseModel extends ChangeNotifier {
  final navigationService = getIt<NavigationService>();
  ViewState _state = ViewState.idle;

  ViewState get state => _state;
  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
