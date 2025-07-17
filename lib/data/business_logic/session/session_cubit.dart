import 'package:elbaraa/data/business_logic/session/session_state.dart';
import 'package:elbaraa/data/repository/session_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionCubit extends Cubit<SessionState> {
  final SessionRepository sessionRepository;


  SessionCubit(this.sessionRepository) : super(SessionInitial());

  Future<Object> getUserCalendar() async {
    var response = await sessionRepository.getUserCalendar();
    if (response.success) {
      emit(SessionsLoaded(response.data!));
      return response.data!;
    } else {
      return {};
    }
  }
}
