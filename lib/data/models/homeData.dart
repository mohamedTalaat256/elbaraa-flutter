import 'package:elbaraa/data/models/instructor.model.dart';
import 'package:elbaraa/data/models/material.model.dart';
import 'package:elbaraa/data/models/plan.model.dart';

class HomeData {
  final List<MaterialModel> materials;
  final List<Instructor> instructors;
  final List<Plan> plans;

  HomeData({required this.materials, required this.instructors,  required this.plans});

  factory HomeData.fromJson(Map<String, dynamic> json) {
    return HomeData(
      materials:
          (json['materials'] as List<dynamic>?)
              ?.map((e) => MaterialModel.fromJson(e))
              .toList() ??
          [],
      instructors:
          (json['instructors'] as List<dynamic>?)
              ?.map((e) => Instructor.fromJson(e))
              .toList() ??
          [],
     plans:
          (json['plans'] as List<dynamic>?)
              ?.map((e) => Plan.fromJson(e))
              .toList() ??
          [],     
    );
  }
}
