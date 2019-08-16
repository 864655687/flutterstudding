import 'package:url_launcher/url_launcher.dart';

/*

调用电话,短信,以及url

*/
class TelAndSmsServiece {
  void call(String number) => launch("tel:$number");
  void sendSms(String number) => launch("sms:$number");
  void sendEamil(String email) => launch("mailto:$email");
  void broswer(String uri) => launch("https://$uri");
}
