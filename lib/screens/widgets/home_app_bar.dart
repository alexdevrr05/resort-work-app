import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.of(context).size.width;
    final hightSize = MediaQuery.of(context).size.height;

    bool isDesktop(BuildContext context) => widthSize >= 600;
    bool isMobile(BuildContext context) => widthSize < 600;

    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 25,
        right: 25,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.welcome,
                style: TextStyle(
                    color: isDesktop(context) ? Colors.white : Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'MontserratSubrayada',
                    ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Alex Ramírez',
                style: TextStyle(
                  color: isDesktop(context) ? Colors.grey.shade300 : null,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  fontFamily: 'Arimo'
                ),
              ),
            ],
          ),
          Row(
            children: [
              // Notification icon
              Container(
                margin: EdgeInsets.only(top: 30, right: 10),
                transform: Matrix4.rotationZ(100),
                child: Stack(
                  children: [
                    Icon(
                      Icons.notifications_none_outlined,
                      size: 30,
                      color: Colors.grey,
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              ClipOval(
                  child: Image.asset(
                'assets/images/avatar.png',
                width: 40,
              ))
            ],
          ),
        ],
      ),
    );
  }
}
