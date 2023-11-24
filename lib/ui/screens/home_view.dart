import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_2/ui/widgets/mars_photo_card.dart';
import '../../logic/mars_photos/mars_photo_cubit/mars_photos_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, this.date});
  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    final MarsPhotosCubit cubit = context.read<MarsPhotosCubit>();
    cubit.clearPhotoList();
    cubit.fetchMarsPhotos(date: date);
    cubit.scrollController.addListener(
      () => cubit.checkScrollPosition(date),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          date == null ? "Latest Photos" : DateFormat.yMMMd().format(date!),
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<MarsPhotosCubit, MarsPhotosState>(
            builder: (context, state) {
              if (cubit.isPhotosLoaded) {
                return cubit.photos.isEmpty
                    ? const Center(
                        child: Column(
                        children: [
                          Icon(
                            Icons.search_off_outlined,
                            size: 100,
                          ),
                          Text('No Photos For This date'),
                        ],
                      ))
                    : Expanded(
                        child: ListView.builder(
                          controller: cubit.scrollController,
                          itemCount: cubit.photos.length,
                          itemBuilder: (_, i) {
                            return MarsPhotoCard(
                                i: i, marsPhoto: cubit.photos[i]);
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
                return const SizedBox(
                  child: Text('Empty'),
                );
              }
            },
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
