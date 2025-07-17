class User {
  final int id;
  final int online;
  final String firstName;
  final String lastName;
  final String education;
  final String email;
  final String country;
  final String imageUrl;
  final String role;
  final int age;
  final String phone;
  final String gender;
  final String phoneVerification;

  User({
    required this.id,
    required this.online,
    required this.firstName,
    required this.lastName,
    required this.education,
    required this.email,
    required this.country,
    required this.imageUrl,
    required this.role,
    required this.age,
    required this.phone,
    required this.gender,
    required this.phoneVerification,
  });
  User.partial({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.imageUrl,
  }) : online = 0,
       education = '',
       email = '',
       country = '',
       role = '',
       age = 0,
       phone = '',
       gender = '',
       phoneVerification = '';


    User.authUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.imageUrl,
    required this.phone,
    required this.country,
    required this.email,
  }) : online = 0,
       education = '',
       role = '',
       age = 0,
       gender = '',
       phoneVerification = '';    

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      online: json['online'] ?? 0,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      education: json['education'] ?? '',
      email: json['email'] ?? '',
      country: json['country'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      role: json['role'] ?? '',
      age: json['age'] ?? 0,
      phone: json['phone'] ?? '',
      gender: json['gender'] ?? '',
      phoneVerification: json['phoneVerfication'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'online': online,
    'firstName': firstName,
    'lastName': lastName,
    'education': education,
    'email': email,
    'country': country,
    'imageUrl': imageUrl,
    'role': role,
    'age': age,
    'phone': phone,
    'gender': gender,
    'phoneVerfication': phoneVerification,
  };
}
