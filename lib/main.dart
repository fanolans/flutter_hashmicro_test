import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hashmicro_test/core/app_provider.dart';
import 'package:flutter_hashmicro_test/core/routes.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

import 'utils/permission_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PermissionHelper.requestLocationPermission();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Hashmicro Test',
        theme: FlexThemeData.light(
          scheme: FlexScheme.mandyRed,
          useMaterial3: true,
        ),
        darkTheme: FlexThemeData.dark(
          scheme: FlexScheme.mandyRed,
          useMaterial3: true,
        ),
        themeMode: ThemeMode.light,
        initialRoute: '/',
        routes: routes,
      ),
    );
  }
}
