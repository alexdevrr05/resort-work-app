import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileTopBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            // top: 25,
            left: 25,
            right: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              AppLocalizations.of(context)!.editProfile,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Row(
              children: [
                Container(
                  child: Stack(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.save,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ],
        ));
  }
}
