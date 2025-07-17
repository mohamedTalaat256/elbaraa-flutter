import 'package:elbaraa/data/business_logic/chat/chat_cubit.dart';
import 'package:elbaraa/data/business_logic/chat/chat_event.dart';
import 'package:elbaraa/data/business_logic/dio_error_handeler.dart';
import 'package:elbaraa/data/repository/chats_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Bloc<ChatEvents, ChatState> {
  ChatRepository chatRepository;

  ChatBloc(this.chatRepository) : super(ChatInitial()) {
    on<ChatEvents>((event, emit) async {
      if (event is SendMessageButtonPressed) {
        emit(SendingMessageLoadingState());

        try {
          var response =
              await chatRepository.sendMessage(event.reciver_id, event.message);

          if (response) {
            emit(MessageSendSuccessState());
          } else {
            emit(MessageSendFailState(message: 'send Faild'));
          }
        } on DioException catch (e) {
          emit(MessageSendFailState(
              message: DioErrorHandler.decodeErrorResponse(e)));
        }
      }
    });
  }
}
