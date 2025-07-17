import 'package:elbaraa/data/models/instructor.model.dart';
import 'package:elbaraa/presentation/screens/home/components/instructor-card.dart';
import 'package:flutter/material.dart';

class InstructorsList extends StatelessWidget {
  final List<Instructor> instructors;

  const InstructorsList({super.key, required this.instructors});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
       final instructor = instructors[index];
      return InstructorCard(instructor: instructor);
    }, childCount: instructors.length));
  }
}
