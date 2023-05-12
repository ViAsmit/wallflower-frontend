import 'package:nitp_social/services/api_services.dart';
import 'package:nitp_social/services/navigation_service.dart';
import 'package:nitp_social/src/screens/on_boarding_flow/complete_profile_screen.dart';
import 'package:nitp_social/view/all_chats_screen_viewmodel.dart';
import 'package:nitp_social/view/complete_profile_screen_viewmodel.dart';
import 'package:nitp_social/view/conversation_screen_viewmodel.dart';
import 'package:nitp_social/view/home_screen_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:nitp_social/view/login_screen_viewmodel.dart';

GetIt getIt = GetIt.instance;
void setupLocator() {
  getIt.registerLazySingleton(() => NavigationService());
  getIt.registerFactory(() => ApiService());
  getIt.registerFactory(() => HomeScreenViewModel());
  getIt.registerFactory(() => LoginViewModel());
  getIt.registerFactory(() => ConversationScreenViewModel());
  getIt.registerFactory(() => AllChatsScreenViewModel());
  getIt.registerLazySingleton(() => CompleteProfileViewModel());
}
