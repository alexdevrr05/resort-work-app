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
  static List<Job> generateJobs() {
    return [
      Job(
        'Google LLC',
        'assets/images/google_logo.png',
        true,
        'Full time',
        'Pto. Vallarta Jalisco',
        'Developer Frontend',
        [
          'Crative with an eye for shape and colour',
          'Understand different materials and production'
        ],
      ),
      Job(
        'Airbnb',
        'assets/images/airbnb_logo.png',
        false,
        'Full time',
        'Pto. Vallarta Jalisco',
        'Dev Full Stack',
        [
          'Crative with an eye for shape and colour',
          'Understand different materials and production'
        ],
      ),
      Job(
        'Linkedin',
        'assets/images/linkedin_logo.png',
        false,
        'Principle Product Desing',
        'Pto. Vallarta Jalisco',
        'Full time',
        [
          'Crative with an eye for shape and colour',
          'Understand different materials and production'
        ],
      )
    ];
  }
}
