import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sizer/sizer.dart';
import 'package:task_2/data/db/init_db.dart';
import 'package:task_2/utils/app_constants.dart';
import 'package:task_2/utils/app_router.dart';
import 'generated/l10n.dart';
import 'utils/color_schemes.g.dart';
import 'utils/typography.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDb();
  await FlutterDownloader.initialize(
    debug: true, // optional: set to false to disable printing logs to console (default: true)
    ignoreSsl: true // option: set to false to disable working with http links (default: false)
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box(AppConstants.ksettingsKey).listenable(),
      builder: (_, box, __) {
        final bool isDark = Hive.box(AppConstants.ksettingsKey)
            .get("isDark", defaultValue: false);
        final String lang =
            Hive.box("settings").get("lang", defaultValue: "en");
        return Sizer(builder: (context, orientation, deviceType) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: Locale(lang),
            title: "app title",
            theme: ThemeData(
              colorScheme: lightColorScheme,
              useMaterial3: true,
              textTheme: textTheme,
            ),
            darkTheme: ThemeData(
              colorScheme: darkColorScheme,
              useMaterial3: true,
              textTheme: textTheme,
            ),
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
            routerConfig: appRouter(),
          );
        });
      },
    );
  }
}
