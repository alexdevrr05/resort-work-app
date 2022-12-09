import 'package:examen/constants/colors.dart';
import 'package:examen/screens/profile/profile.dart';
import 'package:examen/widgets/drawer.dart';
import 'package:flutter/material.dart';

import 'package:examen/screens/widgets/home_app_bar.dart';
import 'package:examen/screens/widgets/job_list.dart';
import 'package:examen/screens/widgets/search_card.dart';
import 'package:examen/screens/widgets/tag_list.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.of(context).size.width;
    final hightSize = MediaQuery.of(context).size.height;

    bool isDesktop(BuildContext context) => widthSize >= 600;
    bool isMobile(BuildContext context) => widthSize < 600;

    return Scaffold(
      drawer: Drawer1(),
      body: Stack(
        children: [
          Row(
            // white space
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  color: isDesktop(context) ? kSecundaryDark : null,
                ),
              ),
              // grey espace
              Expanded(
                flex: 1,
                child: Container(
                  color: isDesktop(context)
                      ? Colors.black
                      : Colors.grey.withOpacity(0.1),
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // HomeAppBar: welcome, notifiction and avatar image
            children: [HomeAppBar(), SearchCard(), TagList(), JobList()],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber.shade300,
        // quita el shadow
        elevation: 0,
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: Theme(
        // para ocultar el colorClick en los buttons
        data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent),
        child: BottomNavigationBar(
          onTap: (value) {
            if (value == 4)
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ProfilePage()));
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: isDesktop(context) ? kSecundaryDark : null,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: isDesktop(context) ? Colors.white : null,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(
                Icons.home,
                size: 20,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Case',
              icon: Icon(
                Icons.cases_outlined,
                size: 20,
              ),
            ),
            BottomNavigationBarItem(label: '', icon: Text('')),
            BottomNavigationBarItem(
              label: 'Chat',
              icon: Icon(
                Icons.chat_outlined,
                size: 20,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Person',
              icon: Icon(
                Icons.person_outline,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
