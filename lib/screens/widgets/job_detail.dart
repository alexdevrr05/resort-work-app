

import 'package:examen/models/job.dart';
import 'package:examen/models/job_test.dart';
import 'package:examen/widgets/icon_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class JobDetail extends StatelessWidget {
  final Job job;
  JobDetail(this.job);
  // final jobListTest = JobServices().getJobs();

  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.of(context).size.width;
    final hightSize = MediaQuery.of(context).size.height;

    bool isDesktop(BuildContext context) => widthSize >= 600;
    bool isMobile(BuildContext context) => widthSize < 600;

    return Container(
      // card bottom
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
          color: isMobile(context) ? Colors.white : const Color(0xFF212121),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 40,
                          padding: EdgeInsets.all(9),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.withOpacity(0.1)),
                          child: Image.asset(job.logoUrl),
                        ),
                        SizedBox(width: 20),
                        Text(
                          job.company,
                          style: TextStyle(
                              fontSize: 16,
                              color: isDesktop(context) ? Colors.white : null),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                            job.isMark
                                ? Icons.bookmark
                                : Icons.bookmark_outline_outlined,
                            color: job.isMark
                                ? Theme.of(context).primaryColor
                                : Colors.black),
                        Icon(Icons.more_horiz_outlined,
                            color: isDesktop(context) ? Colors.white : null),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  job.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: isDesktop(context) ? Colors.white : null),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconText(Icons.location_on_outlined, job.location),
                    IconText(Icons.access_time_outlined, job.time),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  AppLocalizations.of(context)!.requirements,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDesktop(context) ? Colors.white : null,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ...job.req
                    .map((e) => Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                  child: ElevatedButton(
                    onPressed: () async {
                      List resp = await JobServices().getJobs();
                      print('resp -> $resp');
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 0,
                        backgroundColor: Theme.of(context).primaryColor),
                    child: Text(AppLocalizations.of(context)!.applyNow),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
