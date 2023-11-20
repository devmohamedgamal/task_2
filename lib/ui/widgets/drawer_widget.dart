import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../generated/l10n.dart';
import '../../utils/app_constants.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsBox = Hive.box(AppConstants.ksettingsKey);
    return Drawer(
      child: ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            title: Text(S.of(context).theme),
            trailing: Switch(
              value: settingsBox.get("isDark", defaultValue: false),
              onChanged: (v) => settingsBox.put("isDark", v),
            ),
          ),
          ListTile(
            title: Text(S.of(context).language),
            trailing: DropdownButton(
              items: <String>["en", "ar"]
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e == "ar" ? "Arabic" : "English"),
                    ),
                  )
                  .toList(),
              onChanged: (v) => settingsBox.put("lang", v!),
            ),
          ),
        ],
      ),
    );
  }
}
