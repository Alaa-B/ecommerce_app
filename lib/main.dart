import 'package:ecommerce_app/src/app_bootstrap.dart';
import 'package:ecommerce_app/src/app_bootstrap_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  // TODO: INIT FIREBASE ...
  WidgetsFlutterBinding.ensureInitialized();
  // turn off the # in the URLs on the web
  usePathUrlStrategy();
  // create an app bootstrap instance
  final appBootstrap = AppBootstrap();
  // create a container configured with all the "fake" repositories
  final container = await createFirebaseProviderContainer();
  // use the container above to create the root widget
  final root = appBootstrap.createRootWidget(container: container);
  // start the app
  runApp(root);
}
