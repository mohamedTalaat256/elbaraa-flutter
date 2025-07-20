import 'package:elbaraa/data/business_logic/session/session_state.dart';
import 'package:elbaraa/data/repository/session_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionCubit extends Cubit<SessionState> {
  final SessionRepository sessionRepository;


  SessionCubit(this.sessionRepository) : super(SessionInitial());

   Future<void> getUserCalendar() async {
    try {
      final response = await sessionRepository.getUserCalendar();
      
      if (response.success && response.data != null) {
        emit(SessionsLoaded(response.data!));
      } else {
        emit(SessionError(response.message));
      }
    } catch (e) {
      emit(SessionError(e.toString()));
    }
  }
}
