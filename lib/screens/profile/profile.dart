import 'package:examen/screens/profile/widgets/profile_top_banner.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.teal,
                ),
              ),
              // grey espace
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileTopBanner(),
            ],
          ),
        ],
      ),
    );
  }
}
