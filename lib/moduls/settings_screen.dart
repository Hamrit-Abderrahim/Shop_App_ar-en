import 'package:flutter/material.dart';
import 'package:shop_app/shared/style/color.dart';
import 'package:shop_app/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.settings.tr()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.edit,
                  size: 30.0,
                  color: defaultColor,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Text(
                    LocaleKeys.EProfile.tr(),
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w800),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 30.0,
                  color: defaultColor,
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                Icon(
                  Icons.language_outlined,
                  size: 30.0,
                  color: defaultColor,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Text(
                    LocaleKeys.CHgLan.tr(),
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w800),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
