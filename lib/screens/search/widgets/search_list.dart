import 'package:examen/models/job.dart';
import 'package:examen/screens/widgets/job_detail.dart';
import 'package:examen/screens/widgets/job_item.dart';
import 'package:flutter/material.dart';

class SearchList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final jobList = Job.generateJobs(context);

    return Container(
      margin: EdgeInsets.only(
        top: 25,
      ),
      child: ListView.separated(
        padding: EdgeInsets.only(
          left: 25,
          right: 25,
          bottom: 25,
        ),
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
        separatorBuilder: (context, index) => SizedBox(
          height: 20,
        ),
        itemCount: jobList.length,
      ),
    );
  }
}
