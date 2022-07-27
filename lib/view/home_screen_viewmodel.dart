import 'package:nitp_social/provider/base_model.dart';

class HomeScreenViewModel extends BaseModel {
  int counter = 0;

  void incrementCounter() {
    counter++;
    notifyListeners();
  }
}
