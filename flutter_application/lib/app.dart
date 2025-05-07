import 'package:flutter/material.dart';
import 'package:flutter_application/providers/pagenotifier.dart';
import 'package:flutter_application/route/routeinfoparser.dart';
import 'package:flutter_application/route/routerdelegate.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/theme/typography.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: AppRouteInformationParser(),
      routerDelegate: AppRouterDelegate(
        notifier: Provider.of<PageNotifier>(context),
      ),
      title: 'Navigator 2.0',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.brown,
          // ···
          brightness: Brightness.light,
        ),
        textTheme: myTextTheme,
      ),
    );
  }
}
