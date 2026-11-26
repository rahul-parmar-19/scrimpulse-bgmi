import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/services/isar_service.dart';
import 'core/services/notification_service.dart';
import 'core/theme/esports_theme.dart';
import 'data/repositories/esports_repository.dart';
import 'logic/blocs/leaderboard/leaderboard_bloc.dart';
import 'logic/blocs/matches/matches_bloc.dart';
import 'logic/blocs/stream_overlay/stream_cubit.dart';
import 'presentation/screens/home_dashboard_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set immersive dark status and navigation bars for esports aesthetics
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF090B0E),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // Render the Flutter UI immediately so the user never sees a black screen!
  runApp(const ScrimPulseApp());

  // Initialize Firebase and background services asynchronously without blocking the first frame
  _initServices();
}

void _initServices() {
  Firebase.initializeApp().then((_) {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    NotificationService().initialize();
  }).catchError((e) {
    debugPrint('[Firebase Init Note] Running in offline/fallback mode: $e');
  });

  IsarService().init();
}

class ScrimPulseApp extends StatelessWidget {
  const ScrimPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    final esportsRepository = EsportsRepository();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<EsportsRepository>.value(value: esportsRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LeaderboardBloc>(
            create: (context) => LeaderboardBloc(repository: esportsRepository),
          ),
          BlocProvider<MatchesBloc>(
            create: (context) => MatchesBloc(repository: esportsRepository),
          ),
          BlocProvider<StreamCubit>(
            create: (context) => StreamCubit(),
          ),
        ],
        child: MaterialApp(
          title: 'ScrimPulse - BGMI Esports Companion',
          debugShowCheckedModeBanner: false,
          theme: EsportsTheme.darkTheme,
          home: const HomeDashboardScreen(),
        ),
      ),
    );
  }
}
