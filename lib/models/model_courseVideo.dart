import 'dart:convert';
import 'dart:ffi';

class CourseVideoModel {
 
  String title;
  String time;
  String thumbnail;
  String videoUrl;
  String description;


  CourseVideoModel({
    
    required this.title,
    required this.description,
    required this.time,
    required this.thumbnail,
    required this.videoUrl,
    
  });

  
}
