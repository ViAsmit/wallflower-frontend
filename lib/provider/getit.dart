import 'package:nitp_social/services/api_services.dart';
import 'package:nitp_social/services/navigation_service.dart';
import 'package:nitp_social/view/home_screen_viewmodel.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;
void setupLocator() {
  getIt.registerLazySingleton(() => NavigationService());
  getIt.registerFactory(() => ApiService());
  getIt.registerFactory(() => HomeScreenViewModel());
}
