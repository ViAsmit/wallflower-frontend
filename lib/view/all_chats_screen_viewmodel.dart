import 'package:nitp_social/provider/base_model.dart';
import 'package:nitp_social/services/api_response.dart';
import 'package:nitp_social/services/api_services.dart';
import 'package:nitp_social/src/models/users.dart';

class AllChatsScreenViewModel extends BaseModel {
  final ApiService apiService = ApiService();
  List<User> users = [];

  void init() async {
    ApiResponse response = await apiService.getRequest(endpoint: "users/all");
    users = response.data.map<User>((d) => userFromMap(d)).toList();
    notifyListeners();
  }
}
