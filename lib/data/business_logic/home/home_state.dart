

import 'package:elbaraa/data/models/homeData.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}


class HomeDataLoaded extends HomeState {
  final HomeData homeData;

  HomeDataLoaded(this.homeData);

  List<Object> get props => [homeData];
}


 
