import 'package:flutter/material.dart';
import 'package:flutter_demo/screens/AddMoviePage.dart';
import 'package:flutter_demo/screens/Home_Bottom_Nav.dart';
import 'package:provider/provider.dart';
import 'NetworkApi.dart';
import 'base_model.dart';
import 'models/Movie.dart';

void main() {
  runApp(GHFlutterApp());
}

class GHFlutterApp extends StatelessWidget {
  static const apiKey = 'ff6dee5d';
  static var provider = BaseModel(NetworkAPI(apiKey));

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, snapshot) {
      final repository = snapshot.data;
      provider = BaseModel(NetworkAPI(apiKey));
      return MultiProvider(
          providers: [ChangeNotifierProvider.value(value: provider)],
          child: MaterialApp(
            title: "Hello everryOne",
            theme: ThemeData(primaryColor: Colors.green.shade800),
            home: Home(),
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) {
                  return _makeRoute(
                      context: context,
                      routeName: settings.name,
                      arguments: settings.arguments);
                },
                maintainState: true,
                fullscreenDialog: false,
              );
            },
          ));
    });
  }

  Widget _makeRoute(
      {@required BuildContext context,
      @required String routeName,
      Object arguments}) {
    final Widget child = _buildRoute(
      context: context,
      routeName: routeName,
      arguments: arguments,
    );
    return child;
  }

  Widget _buildRoute({
    @required BuildContext context,
    @required String routeName,
    Object arguments,
  }) {
    switch (routeName) {
      case '/list':
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: provider,
            )
          ],
          child: AddMoviePage(),
        );
      case '/filter':
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: provider,
            )
          ],
          child: AddMoviePage(),
        );
      case '/stats':
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: provider,
            )
          ],
          child: AddMoviePage(),
        );
      case '/details':
        final map = arguments as Map<String, dynamic> ?? Map();
        final item = map['item'] as Movie;

        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: provider,
            )
          ],
          child: AddMoviePage(),
        );
      case '/add':
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: provider,
            )
          ],
          child: AddMoviePage(),
        );
      case '/flutterState':
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: provider,
            )
          ],
          child: AddMoviePage(),
        );
      default:
        return Container();
    }
  }
}
