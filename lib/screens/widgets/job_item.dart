import 'package:examen/constants/colors.dart';
import 'package:examen/widgets/icon_text.dart';
import 'package:flutter/material.dart';
// Model
import 'package:examen/models/job.dart';

class JobItem extends StatelessWidget {
  final Job job;
  final bool showTime;

  JobItem(this.job, {this.showTime = false});

  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.of(context).size.width;
    final hightSize = MediaQuery.of(context).size.height;

    bool isDesktop(BuildContext context) => widthSize >= 600;
    bool isMobile(BuildContext context) => widthSize < 600;

    return Container(
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
                    child: Image.asset(job.logoUrl),
                  ),
                  SizedBox(width: 10),
                  Text(
                    job.company,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              // Icon saved
              Icon(
                  job.isMark ? Icons.bookmark : Icons.bookmark_outline_outlined,
                  color: job.isMark
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
            job.title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDesktop(context) ? Colors.grey.shade300 : null),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconText(Icons.location_on_outlined, job.location),
              if (showTime) IconText(Icons.access_time_outlined, job.time)
            ],
          ),
        ],
      ),
    );
  }
}
