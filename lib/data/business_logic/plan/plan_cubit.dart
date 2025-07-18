import 'package:elbaraa/data/business_logic/plan/plan_state.dart';
import 'package:elbaraa/data/models/material.model.dart';
import 'package:elbaraa/data/models/plan.model.dart';
import 'package:elbaraa/data/repository/plan_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanCubit extends Cubit<PlanState> {
  final PlanRepository planRepository;

  PlanCubit(this.planRepository) : super(PlanInitial());

  Future<void> findById(int id) async {
    var response = await planRepository.findById(id);
    if (response.success && response.data is Map<String, dynamic>) {
      final data = response.data as Map<String, dynamic>;
      final plan = data['plan'] as Plan;
      final materials = data['materials'] as List<MaterialModel>;
      emit(PlanWithMaterialsLoaded(plan, materials));
    }
  }


}
