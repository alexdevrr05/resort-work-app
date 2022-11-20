import 'package:examen/models/job.dart';
import 'package:examen/screens/widgets/job_detail.dart';
import 'package:examen/screens/widgets/job_item.dart';
import 'package:flutter/material.dart';

class JobList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  final jobList = Job.generateJobs(context);
    return Container(
        margin: EdgeInsets.symmetric(
          vertical: 25,
        ),
        height: 160,
        child: ListView.separated(
            padding: EdgeInsets.symmetric(
              horizontal: 25,
            ),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        context: context,
                        builder: ((context) => JobDetail(jobList[index])));
                  },
                  child: JobItem(jobList[index]),
                ),
            separatorBuilder: (_, index) => SizedBox(
                  width: 15,
                ),
            itemCount: jobList.length));
  }
}
