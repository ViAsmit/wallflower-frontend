import 'package:flutter/material.dart';
import 'package:nitp_social/enum/view_state.dart';
import 'package:nitp_social/provider/base_model.dart';
import 'package:nitp_social/services/api_response.dart';
import 'package:nitp_social/services/api_services.dart';
import 'package:nitp_social/services/prefs_services.dart';

class LoginViewModel extends BaseModel {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Prefs prefs = Prefs();

  Future<void> login() async {
    print(emailController.text);
    print(passwordController.text);
    print("login");

    setState(ViewState.busy);

    final ApiResponse response =
        await apiService.postRequest("/users/register", {
      "email": emailController.text,
      "password": passwordController.text,
    });

    print(response.data);
    print(response.errorMessage);

    if (response.error) {
      ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(SnackBar(
        content: Text(response.errorMessage),
      ));
      setState(ViewState.idle);
      return;
    }
    print(response.data);
    await prefs.setUID(response.data["_id"]);
    if (response.data["isNew"] == true) {
      navigationService.navigateTo("/onboarding", withreplacement: true);
    } else {
      navigationService.navigateTo("/all-chats", withreplacement: true);
    }
    setState(ViewState.idle);
  }
}
