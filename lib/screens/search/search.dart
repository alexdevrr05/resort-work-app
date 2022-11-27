import 'package:examen/screens/search/widgets/search_input.dart';
import 'package:examen/screens/search/widgets/search_list.dart';
import 'package:examen/screens/search/widgets/search_option.dart';
import 'package:flutter/material.dart';
import 'package:examen/screens/search/widgets/search_top_banner.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            // white space
            children: [
              Expanded(
                flex: 2,
                child: Container(),
              ),
              // grey espace
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.grey.withOpacity(0.1),
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchTopBanner(),
              SearchInput(),
              SearchOption(),
              Expanded(child: SearchList()),
            ],
          ),
        ],
      ),
    );
  }
}
