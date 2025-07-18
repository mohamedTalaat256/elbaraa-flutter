

import 'package:elbaraa/data/models/material.model.dart';
import 'package:elbaraa/data/models/plan.model.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class PlanState {}

class PlanInitial extends PlanState {}


class PlansLoaded extends PlanState {
  final List<Plan> plans;

  PlansLoaded(this.plans);

  List<Object> get props => [plans];
}


class PlanLoaded extends PlanState {
  final Plan plan;
  PlanLoaded(this.plan);
}

class PlanWithMaterialsLoaded extends PlanState {
  final Plan plan;
  final List<MaterialModel> materials;
  PlanWithMaterialsLoaded(this.plan, this.materials);
}


class MaterialSelectionChanged extends PlanState {
  final Plan plan;
  final List<MaterialModel> materials;
  MaterialSelectionChanged(this.plan, this.materials);
}


 
