class Instructor {
  final String firstName;
  final String lastName;
  final String country;
  final String imageUrl;
  final String education;
  final int age;
  final String gender;
  final String jobTitle;


  Instructor({
    required this.firstName,
    required this.lastName,
    required this.country,
    required this.imageUrl,
    required this.education,
    required this.age,
    required this.gender,
    required this.jobTitle,
  });

  factory Instructor.fromJson(Map<String, dynamic> json) {
    return Instructor(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      country: json['country'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      education: json['education'] ?? '',
      age: json['age'] ?? '',
      gender: json['gender'] ?? '',
      jobTitle: json['jobTitle'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'country': country,
        'imageUrl': imageUrl,
        'education': education,
        'age': age,
        'gender': gender,
        'jobTitle': jobTitle,
      };
}