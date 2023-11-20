import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:task_2/data/repos/mars_photos_repo.dart';

import '../../generated/l10n.dart';
import '../widgets/drawer_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).appTitle,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      drawer: const DrawerWidget(),
      body: Center(
          child: Container(
        width: 50.w,
        padding: EdgeInsets.all(15.sp),
        color: Theme.of(context).colorScheme.error,
        child: Text(S.of(context).appTitle),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          MarsPhotosRepo().fetchDatePhotos(earthDate: DateTime(2021, 11, 20));
        },
        child: const Icon(Icons.webhook),
      ),
    );
  }
}
