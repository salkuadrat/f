import 'screens/home/home.dart';
import 'screens/login/login.dart';
import 'screens/splash/splash.dart';
import 'screens/users/users.dart';

/// generate template for screens
void screens(String project, String template) {
  String dir = '$project/lib/screens';

  splash(project, dir, template);
  home(project, dir, template);
  login(project, dir, template);
  users(project, dir, template);
}
