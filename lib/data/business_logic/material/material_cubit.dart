import 'package:elbaraa/data/business_logic/material/material_state.dart';
import 'package:elbaraa/data/repository/material_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaterialCubit extends Cubit<MaterialState> {
  final MaterialRepository materialRepository;


  MaterialCubit(this.materialRepository) : super(MaterialInitial());

  Future<void> getAllActiveMaterials() async {
    var response = await materialRepository.getAllActiveMaterials();
    if (response.success) {
      emit(MaterialsLoaded(response.data!));
    }
  }
}
