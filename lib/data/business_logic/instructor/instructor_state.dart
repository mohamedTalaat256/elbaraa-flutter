

import 'package:elbaraa/data/models/instructor.model.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class InstructorState {}

class InstructorInitial extends InstructorState {}


class InstructorsLoaded extends InstructorState {
  final List<Instructor> instructors;
  InstructorsLoaded(this.instructors);
}


class InstructorsByMaterialLoaded extends InstructorState {
  final List<Instructor> instructors;
  InstructorsByMaterialLoaded(this.instructors);
}

class MaterialSelectionChanged extends InstructorState {
  final List<Instructor> instructors;
  MaterialSelectionChanged(this.instructors);
}




 
