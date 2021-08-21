import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:penger/config/theme.dart';
import 'package:penger/helpers/notification/push_notification_manager.dart';
import 'package:penger/providers/multi_bloc_provider.dart';
import 'package:penger/splash.dart';
import 'package:flutter_config/flutter_config.dart';
// import 'package:penger/main.mapper.g.dart' show initializeJsonMapper;

// ignore: avoid_void_async
void main() async {
  await dotenv.load(fileName: ".env");
  // initializeJsonMapper();
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  await PushNotificationManager().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: multiBlocProviders(context),
      child: MaterialApp(
        title: 'Penger',
        theme: themeData,
        home: const Splash(),
      ),
    );
  }
}
