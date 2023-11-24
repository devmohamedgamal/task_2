import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_2/data/repos/mars_photo_repo_impl.dart';
import 'package:task_2/logic/mars_photos/rover_details_cubit/rover_details_cubit.dart';
import 'package:task_2/ui/screens/home_view.dart';
import 'package:task_2/ui/screens/landing_view.dart';
import 'package:task_2/ui/screens/settings_view.dart';
import 'package:task_2/utils/app_constants.dart';

GoRouter appRouter() {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => BlocProvider(
          create: (context) =>
              RoverDetailsCubit(MarsPhotosRepoImpl())..fetchRoverData(),
          child: const LandingView(),
        ),
      ),
      GoRoute(
        path: AppConstants.homeView,
        builder: (context, state) => HomeView(
          date: state.extra as DateTime?,
        ),
      ),
      GoRoute(
        path: AppConstants.ksettingsView,
        builder: (context, state) => const SettingsView(),
      ),
    ],
  );
}
