import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class JobServices {
  Future<List<JobServices>> getJobs() async {
    List<JobServices> myJobs = [];

    // try {
    //   final ref = FirebaseDatabase.instance.reference();
    //   final snapshot = await ref.child('jobs').get();

    //   if (snapshot.exists) {
    //     final data = snapshot.value;
    //     // myJobs.add(data);
    //   } else {
    //     print('No data available.');
    //   }

    //   return myJobs;
    // } catch (e) {
    //   print('CATCH');
    //   return myJobs;
    // }

    try {
      DatabaseReference snap = FirebaseDatabase.instance.ref("example/jobs");

      await snap.push().set({
        "name": "Juan",
        "age": 20,
      });
      
      // await snap.set({
      //   "1": {
      //     "name": "Alex",
      //     "age": 20,
      //   }
      // });

      return myJobs;
    } catch (e) {
      print('CATCH');
      return myJobs;
    }
  }
}
