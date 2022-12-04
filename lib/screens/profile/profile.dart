import 'package:examen/screens/profile/widgets/profile_input.dart';
import 'package:examen/screens/profile/widgets/profile_top_banner.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.teal,
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.white,
                  // child: Text('heo'),
                ),
              ),
              // grey espace
            ],
          ),
          Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProfileTopBanner(),
              SizedBox(
                height: 70,
              ),
              Container(
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/images/avatar.png",
                      width: 140,
                      height: 140,
                    ),
                    Positioned(
                      bottom: 5,
                      right: 0,
                      child: Container(
                        child: Icon(Icons.camera_alt_outlined),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  SizedBox(height: 70),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileInput(AppLocalizations.of(context)!.username, ''),
                      ProfileInput(AppLocalizations.of(context)!.phone, ''),
                      ProfileInput(AppLocalizations.of(context)!.email, ''),
                      ProfileInput(AppLocalizations.of(context)!.gender, ''),
                      ProfileInput(AppLocalizations.of(context)!.date, ''),
                    ],
                  ),
                ],
              ),
              Container(
                child: Expanded(
                  flex: 2,
                  child: Container(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
