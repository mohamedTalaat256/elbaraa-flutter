

import 'package:elbaraa/data/models/material.model.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class MaterialState {}

class MaterialInitial extends MaterialState {}


class MaterialsLoaded extends MaterialState {
  final List<MaterialModel> materials;

  MaterialsLoaded(this.materials);

  List<Object> get props => [materials];
}


 
