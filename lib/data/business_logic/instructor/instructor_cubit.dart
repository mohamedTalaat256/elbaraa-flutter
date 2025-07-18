import 'package:elbaraa/data/business_logic/instructor/instructor_state.dart';
import 'package:elbaraa/data/repository/instructor_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InstructorCubit extends Cubit<InstructorState> {
  final InstructorRepository instructorRepository;

  InstructorCubit(  this.instructorRepository) : super(InstructorInitial());

 
 
  Future<void> getActiveInstructorByMaterialI(int materialId) async {
    var response = await instructorRepository.getActiveInstructorByMaterialI(materialId);
    if (response.success) {
      emit(InstructorsByMaterialLoaded(response.data!));
    }
  }
}
