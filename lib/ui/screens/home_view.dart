import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:task_2/utils/app_constants.dart';
import 'package:task_2/utils/app_router.dart';

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
    );
  }
}
