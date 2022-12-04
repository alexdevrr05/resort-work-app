import 'package:examen/screens/search/search.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(25),
      padding: EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 40,
      ),
      height: 300,
      width: double.maxFinite,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
              image: AssetImage(
                'assets/images/search_bg.png',
              ),
              fit: BoxFit.cover)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.cardTitle,
            style: TextStyle(color: Colors.white, fontSize: 26, fontFamily: 'Arimo'),
          ),
          SizedBox(height: 10),
          Text(
            
          AppLocalizations.of(context)!.cardSubtitle,
            // 'You can search quickly for\nthe job you want',
            style: TextStyle(
                height: 1.6, color: Colors.white, fontWeight: FontWeight.w400, fontFamily: 'MontserratSubrayada'),
          ),
          SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => SearchPage()));
            },
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/search.png',
                    width: 20,
                  ),
                  SizedBox(width: 10),
                  Text(
                    AppLocalizations.of(context)!.cardSearch,
                    style: TextStyle(color: Colors.grey, fontSize: 18, fontFamily: 'Arimo'),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
