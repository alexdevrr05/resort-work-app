import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class JobServices {
  Future<List<JobServices>> getJobs() async {
    List<JobServices> myJobs = [];

    try {
      DatabaseReference snap = FirebaseDatabase.instance.ref("jobs");

      // await snap.push().set({
      //   "name": "Juan",
      //   "age": 22,
      // });

      snap.onValue.listen((DatabaseEvent event) {
        final data = event.snapshot.value;
        print('data $data');
      });

      // await snap.set({
      //   "1": {
      //     "name": "Alex",
      //     "age": 20,
      //   }
      // });

      // print('EPAAA $data');

      return myJobs;
    } catch (e) {
      print('CATCH');
      return myJobs;
    }
  }
}
