class Plan {
  final int id;
  final String title;
  final String description;
  final int sessionPerMonth;
  final int sessionPrice;
  final int studentCount;
  final double sessionDuration;
  final int planCost;
  final String currency;
  final int active;
  final int order;
  final String createdAt;
  final String updatedAt;

  Plan({
    required this.id,
    required this.title,
    required this.description,
    required this.sessionPerMonth,
    required this.sessionPrice,
    required this.studentCount,
    required this.sessionDuration,
    required this.planCost,
    required this.currency,
    required this.active,
    required this.order,
    required this.createdAt,
    required this.updatedAt,
  });

factory Plan.fromJson(Map<String, dynamic> json) {
  return Plan(
    id: json['id'] ?? 0,
    title: json['title'] ?? '',
    description: json['description'] ?? '',
    sessionPerMonth: (json['sessionPerMonth'] ?? 0).toInt(),
    sessionPrice: (json['sessionPrice'] ?? 0).toInt(),
    studentCount: (json['studentCount'] ?? 0).toInt(),
    sessionDuration: (json['sessionDuration'] ?? 0).toDouble(),
    planCost: (json['planCost'] ?? 0).toInt(),
    currency: json['currency'] ?? '',
    active: (json['active'] ?? 0).toInt(),
    order: (json['order'] ?? 0).toInt(),
    createdAt: json['createdAt'] ?? '',
    updatedAt: json['updatedAt'] ?? '',
  );
}

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'sessionPerMonth': sessionPerMonth,
        'sessionPrice': sessionPrice,
        'studentCount': studentCount,
        'sessionDuration': sessionDuration,
        'planCost': planCost,
        'currency': currency,
        'active': active,
        'order': order,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
