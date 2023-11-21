import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:task_2/data/models/mars_photo_model/mars_photo_model.dart';
import 'package:task_2/data/models/mars_photo_model/rover_model.dart';
import 'package:task_2/data/repos/mars_photos_repo.dart';
import 'package:task_2/utils/app_constants.dart';
import '../../generated/l10n.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/mars_photo_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool dataReady = false;
  List<MarsPhotoModel> marsPhotos = [];
  @override
  void initState() {
    MarsPhotosRepo().fetchRoverDetails().then((bool value) {
      dataReady = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final RoverModel rover = Hive.box<RoverModel>(AppConstants.kRoverKey)
        .get(AppConstants.kRoverDetails)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).appTitle,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      drawer: const DrawerWidget(),
      body: !dataReady
          ? const Text('Loading')
          : Column(
              children: [
                ListTile(
                  title: Text(S.of(context).date),
                  trailing: const Icon(Icons.calendar_month_outlined),
                  onTap: () async {
                    DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: rover.maxDate,
                      firstDate: rover.landingDate,
                      lastDate: rover.maxDate,
                    );
                    marsPhotos = await MarsPhotosRepo().fetchDatePhotos(
                      earthDate: date ?? rover.maxDate,
                    );
                    setState(() {});
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: marsPhotos.length,
                    itemBuilder: (_, i) {
                      return MarsPhotoCard(marsPhoto: marsPhotos[i]);
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // MarsPhotosRepo().fetchDatePhotos(earthDate: DateTime(2021, 11, 20));
          MarsPhotosRepo().fetchRoverDetails();
        },
        child: const Icon(Icons.webhook),
      ),
    );
  }
}
