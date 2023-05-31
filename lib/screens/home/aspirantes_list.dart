import 'package:examen/widgets/icon_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../home/apply.dart';

class AspirantesList extends StatefulWidget {
  AspirantesList({Key? key}) : super(key: key);

  @override
  State<AspirantesList> createState() => _AspirantesListState();
}

class _AspirantesListState extends State<AspirantesList> {
  final DatabaseReference databaseRef =
      FirebaseDatabase.instance.reference().child('postulaciones');

  void showAspiranteDetails(
      BuildContext context, Map<String, dynamic> aspirante) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                aspirante['aspirante_name'] ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 10),
              Text(
                aspirante['aspirante_email'] ?? '',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                aspirante['phone'] ?? '',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                aspirante['address'] ?? '',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 10),
              Image.network(
                aspirante['logoUrl'] ?? '',
                width: 50,
                height: 50,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<DatabaseEvent>(
          future: databaseRef.once(),
          builder:
              (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            final DataSnapshot dataSnapshot = snapshot.data!.snapshot;
            final Map<dynamic, dynamic> data =
                dataSnapshot.value as Map<dynamic, dynamic>;
            final List<String> titles = data.keys.cast<String>().toList();

            return ListView.builder(
              itemCount: titles.length,
              itemBuilder: (BuildContext context, int index) {
                final String title = titles[index];
                final Map<String, dynamic> record = data[title];
                final List<Map<String, dynamic>> aspirantes =
                    record.values.cast<Map<String, dynamic>>().toList();

                return ExpansionTile(
                  title: Row(
                    children: [
                      SizedBox(width: 10),
                      Image.network(
                        aspirantes[0]['logoUrl'] ??
                            '', // Use the first aspirante's logoUrl
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(width: 10),
                      Text(title),
                    ],
                  ),
                  children: aspirantes.map((aspirante) {
                    final String aspiranteEmail =
                        aspirante['aspirante_email'] ?? '';
                    final String aspiranteName =
                        aspirante['aspirante_name'] ?? '';
                    final String logoUrl = aspirante['logoUrl'] ?? '';

                    return ListTile(
                      onTap: () => showAspiranteDetails(context, aspirante),
                      title: Row(
                        children: [
                          SizedBox(width: 10),
                          Text(aspiranteName),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          SizedBox(width: 10),
                          Text(aspiranteEmail),
                        ],
                      ),
                      // leading: Image.network(logoUrl),
                    );
                  }).toList(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
