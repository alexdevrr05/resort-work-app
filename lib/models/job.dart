import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Job {
  String company;
  String logoUrl;
  bool isMark;
  String title;
  String location;
  String time;
  List<String> req;
  Job(
    this.company,
    this.logoUrl,
    this.isMark,
    this.time,
    this.location,
    this.title,
    this.req,
  );
  static List<Job> generateJobs(context) {
    return [
      Job(
        'Google LLC',
        'assets/images/google_logo.png',
        true,
        AppLocalizations.of(context)!.jobTime,
        'Pto. Vallarta Jalisco',
        AppLocalizations.of(context)!.jobDevFront,
        // 'Developer Frontend',
        [
          AppLocalizations.of(context)!.reqFront1,
          AppLocalizations.of(context)!.reqFront2,
          AppLocalizations.of(context)!.reqFront3,
          AppLocalizations.of(context)!.reqFront4,
        ],
      ),
      Job(
        'Airbnb',
        'assets/images/airbnb_logo.png',
        false,
        AppLocalizations.of(context)!.jobTime,
        'Pto. Vallarta Jalisco',
         AppLocalizations.of(context)!.jobDevFullStack,
        [
          AppLocalizations.of(context)!.reqFullStack1,
          AppLocalizations.of(context)!.reqFullStack2,
          AppLocalizations.of(context)!.reqFullStack3,
          AppLocalizations.of(context)!.reqFullStack4,
          AppLocalizations.of(context)!.reqFullStack5
        ],
      ),
      Job(
        'Linkedin',
        'assets/images/linkedin_logo.png',
        false,
        AppLocalizations.of(context)!.jobTime,
        'Pto. Vallarta Jalisco',
        AppLocalizations.of(context)!.jobDevops,
        [
          AppLocalizations.of(context)!.reqDevops1,
          AppLocalizations.of(context)!.reqDevops2,
          AppLocalizations.of(context)!.reqDevops3,
          AppLocalizations.of(context)!.reqDevops4,
          AppLocalizations.of(context)!.reqDevops5
        ],
      )
    ];
  }
}
