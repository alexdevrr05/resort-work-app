import 'package:examen/constants/colors.dart';
import 'package:examen/widgets/icon_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../home/apply.dart';

class SearchList extends StatefulWidget {
  SearchList({Key? key}) : super(key: key);

  @override
  State<SearchList> createState() => _searchList();
}

class _searchList extends State<SearchList> {
  final databaseRef = FirebaseDatabase.instance.ref('jobs');

  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.of(context).size.width;
    final hightSize = MediaQuery.of(context).size.height;

    bool isDesktop(BuildContext context) => widthSize >= 600;
    bool isMobile(BuildContext context) => widthSize < 600;
    return Scaffold(
      body: SafeArea(
          child: FirebaseAnimatedList(
        query: databaseRef,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          var value = Map<String, dynamic>.from(snapshot.value as Map);
          // return Text('hello');
          var x = value['title'];
          return InkWell(
              onTap: () {
                // Acciones a realizar al presionar el Container

                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding: EdgeInsets.all(25),
                      decoration: BoxDecoration(
                          color: isMobile(context)
                              ? Colors.white
                              : const Color(0xFF212121),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          )),
                      height: 550,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.grey.withOpacity(0.3),
                              height: 5,
                              width: 60,
                            ),
                            // Separación
                            SizedBox(
                              height: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 40,
                                          padding: EdgeInsets.all(9),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color:
                                                  Colors.grey.withOpacity(0.1)),
                                          child: value['logoUrl']
                                                      .substring(0, 6) ==
                                                  "assets"
                                              ? Image.asset(value['logoUrl'])
                                              : Image.network(value['logoUrl']),
                                        ),
                                        SizedBox(width: 20),
                                        Text(
                                          value['company'],
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: isDesktop(context)
                                                  ? Colors.white
                                                  : null),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                            value['isMark']
                                                ? Icons.bookmark
                                                : Icons
                                                    .bookmark_outline_outlined,
                                            color: value['isMark']
                                                ? Theme.of(context).primaryColor
                                                : Colors.black),
                                        Icon(Icons.more_horiz_outlined,
                                            color: isDesktop(context)
                                                ? Colors.white
                                                : null),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Text(
                                  value['title'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26,
                                      color: isDesktop(context)
                                          ? Colors.white
                                          : null),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconText(Icons.location_on_outlined,
                                        value['location']),
                                    IconText(Icons.access_time_outlined,
                                        value['time']),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.requirements,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isDesktop(context)
                                        ? Colors.white
                                        : null,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ...value['req']
                                    .map((e) => Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                top: 10,
                                              ),
                                              height: 5,
                                              width: 5,
                                              // Lista
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: isDesktop(context)
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            ConstrainedBox(
                                              constraints: BoxConstraints(
                                                maxWidth: 300,
                                              ),
                                              child: Text(
                                                e,
                                                style: TextStyle(
                                                    wordSpacing: 2.5,
                                                    height: 1.5,
                                                    color: isDesktop(context)
                                                        ? Colors.white
                                                        : null),
                                              ),
                                            )
                                          ],
                                        )))
                                    .toList(),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 25),
                                  height: 45,
                                  width: double.maxFinite,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => ApplyScreen(
                                                    vacancy: value,
                                                  )));
                                    },
                                    child: Text(
                                        AppLocalizations.of(context)!.applyNow),
                                    style: ElevatedButton.styleFrom(
                                        primary:
                                            Color.fromARGB(255, 39, 126, 126))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                margin: EdgeInsets.only(top: 25),
                width: 270,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: isMobile(context) ? Colors.white : kSecundaryDark,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.withOpacity(0.1),
                              ),

                              // child: Image.asset(value['logoUrl']),
                              child:
                                  value['logoUrl'].substring(0, 6) == "assets"
                                      ? Image.asset(value['logoUrl'])
                                      : Image.network(value['logoUrl']),
                            ),
                            SizedBox(width: 10),
                            Text(
                              value['company'],
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        // Icon saved
                        Icon(
                            value['isMark']
                                ? Icons.bookmark
                                : Icons.bookmark_outline_outlined,
                            color: value['isMark']
                                ? Theme.of(context).primaryColor
                                : isDesktop(context)
                                    ? Colors.white
                                    : Colors.black)
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      value['title'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              isDesktop(context) ? Colors.grey.shade300 : null),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconText(Icons.location_on_outlined, value['location']),
                        IconText(Icons.access_time_outlined, value['time'])
                      ],
                    ),
                  ],
                ),
              ));
        },
      )),
    );
  }
}
