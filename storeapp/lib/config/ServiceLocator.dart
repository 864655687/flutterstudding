import 'TelAndSmsService.dart';
import 'package:get_it/get_it.dart';


GetIt locator = GetIt();

void setupLocator(){

  locator.registerSingleton(TelAndSmsServiece());
}