import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:task_2/data/models/mars_photo_model/rover_model.dart';
import 'package:task_2/logic/mars_photos/rover_details_cubit/rover_details_cubit.dart';
import 'package:task_2/ui/widgets/mars_photo_card.dart';
import 'package:task_2/utils/app_constants.dart';
import '../../generated/l10n.dart';
import '../../logic/mars_photos/mars_photo_cubit/mars_photos_cubit.dart';
import '../widgets/drawer_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final RoverModel rover = Hive.box<RoverModel>(AppConstants.kRoverKey)
        .get(AppConstants.kRoverDetails)!;
    late DateTime? date;
    return BlocBuilder<RoverDetailsCubit, RoverDetailsState>(
      builder: (context, state) {
        if (state is RoverDetailsSuccess) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                S.of(context).appTitle,
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            drawer: const DrawerWidget(),
            body: Column(
              children: [
                ListTile(
                  title: Text(S.of(context).date),
                  trailing: const Icon(Icons.calendar_month_outlined),
                  onTap: () async {
                    date = await showDatePicker(
                      context: context,
                      initialDate: rover.maxDate,
                      firstDate: rover.landingDate,
                      lastDate: rover.maxDate,
                    );
                    // ignore: use_build_context_synchronously
                    BlocProvider.of<MarsPhotosCubit>(context)
                        .fetchDateMarsPhotos(date: date!);
                  },
                ),
                BlocBuilder<MarsPhotosCubit, MarsPhotosState>(
                  builder: (context, state) {
                    if (state is MarsPhotosSuccess) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: state.photos.length,
                          itemBuilder: (_, i) {
                            return MarsPhotoCard(marsPhoto: state.photos[i]);
                          },
                        ),
                      );
                    } else if (state is MarsPhotosFailure) {
                      return Center(
                        child: Text(state.errMessage),
                      );
                    } else if (state is MarsPhotosLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // MarsPhotosRepo().fetchDatePhotos(earthDate: DateTime(2021, 11, 20));
                // MarsPhotosRepo().fetchRoverDetails();
              },
              child: const Icon(Icons.webhook),
            ),
          );
        } else if (state is RoverDetailsFailure) {
          return Center(
            child: Text(state.errMessage),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
