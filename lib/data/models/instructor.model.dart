import 'package:elbaraa/data/models/session.model.dart';
import 'package:elbaraa/data/models/unavailableTime.model.dart';

class Instructor {
  final int id;
  final String firstName;
  final String lastName;
  final String country;
  final String imageUrl;
  final String education;
  final int age;
  final String gender;
  final String jobTitle;
  final List<UnavailableTime> unavailableTimes;
  final List<Session> sessions;

  Instructor({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.country,
    required this.imageUrl,
    required this.education,
    required this.age,
    required this.gender,
    required this.jobTitle,
    required this.unavailableTimes,
    required this.sessions,
  });

  factory Instructor.fromJson(Map<String, dynamic> json) {
    return Instructor(
      id: json['id'] ?? 0,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      country: json['country'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      education: json['education'] ?? '',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? '',
      jobTitle: json['jobTitle'] ?? '',
      unavailableTimes: (json['unavailableTimes'] as List<dynamic>?)
              ?.map((e) => UnavailableTime.fromJson(e))
              .toList() ??
          [],
      sessions: (json['sessions'] as List<dynamic>?)
             ?.map((e) => Session.fromJson(e))
             .toList() ??
         [],    
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'country': country,
        'imageUrl': imageUrl,
        'education': education,
        'age': age,
        'gender': gender,
        'jobTitle': jobTitle,
        'unavailableTimes': unavailableTimes.map((e) => e.toJson()).toList(),
        'sessions': sessions.map((e) => e.toJson()).toList(),
      };
}
