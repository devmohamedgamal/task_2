import 'package:go_router/go_router.dart';
import 'package:task_2/ui/screens/home_view.dart';
import 'package:task_2/ui/screens/settings_view.dart';
import 'package:task_2/utils/app_constants.dart';

GoRouter appRouter() {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: AppConstants.ksettingsView,
        builder: (context, state) => const SettingsView(),
      ),
    ],
  );
}
