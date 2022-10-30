

class CourseModel {
  String id;
  String title;
  String subtitle;
  String highestQualification;
  String image;
  int price;


  CourseModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.highestQualification,
    required this.image,
    required this.price,
 
  });
}
class ClassModel {
  String id;
  String title;
  String subtitle;
  String image;
  int duration;
  int videos;

  ClassModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.duration,

    required this.videos,
  });
}
