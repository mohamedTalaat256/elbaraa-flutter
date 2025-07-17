class MaterialModel {
  final String title;
  final String description;
  final String image;

  MaterialModel({required this.title, required this.description, required this.image});

  factory MaterialModel.fromJson(Map<String, dynamic> json) {
    return MaterialModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'image': image,
      };
}
