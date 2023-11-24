import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';

import '../../data/models/mars_photo_model/rover_model.dart';
import '../../logic/mars_photos/mars_photo_cubit/mars_photos_cubit.dart';
import '../../utils/app_constants.dart';
import '../widgets/drawer_widget.dart';

class LandingView extends StatelessWidget {
  const LandingView({super.key});

  @override
  Widget build(BuildContext context) {
    final RoverModel rover = Hive.box<RoverModel>(AppConstants.kRoverKey)
        .get(AppConstants.kRoverDetails)!;
    final MarsPhotosCubit cubit = context.read<MarsPhotosCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      drawer: const DrawerWidget(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                context.push(AppConstants.homeView);
              },
              child: const Text('Latest Photos')),
          const SizedBox(
            height: 50,
            width: double.infinity,
          ),
          ElevatedButton(
              onPressed: () async {
                showDatePicker(
                  context: context,
                  initialDate: rover.maxDate,
                  firstDate: rover.landingDate,
                  lastDate: rover.maxDate,
                ).then((date) {
                  if (date != null) {
                    cubit.clearPhotoList();
                    cubit.fetchDateMarsPhotos(date: date);
                    context.push(AppConstants.homeView, extra: date);
                  }
                });
              },
              child: const Text('Date Photos')),
        ],
      ),
    );
  }
}
