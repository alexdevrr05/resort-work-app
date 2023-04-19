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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: value['req'].length,
                              itemBuilder: (BuildContext context, int index) {
                                var x2 = value['title'];
                                print('$x2');
                                final texto = value['req'][index];
                                return ListTile(
                                  title: Text(texto),
                                  onTap: () {
                                    // Hacer algo cuando se presiona el elemento de la lista
                                    Navigator.of(context).pop();
                                  },
                                );
                              },
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ApplyScreen(
                                        vacancy: value,
                                      )));
                            },
                            child: Text(AppLocalizations.of(context)!.applyNow),
                          ),
                        ],
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
                              child: Image.asset(value['logoUrl']),
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
