import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class SearchList extends StatefulWidget {
  SearchList({Key? key}) : super(key: key);
  @override
  State<SearchList> createState() => _searchList();
}

class _searchList extends State<SearchList> {
  final databaseRef = FirebaseDatabase.instance.ref('example').child('jobs');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FirebaseAnimatedList(
        query: databaseRef,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
        Animation<double> animation, int index) {
        var value = Map<String, dynamic>.from(snapshot.value as Map);
          // print('value $value.name');
          // return Text('hello');
          var x = value['name'];
          print('x -> $x');
          return ListTile(
            title: Text(value['company']),
          );
        },
      )),
      
    );
    
  }
}

