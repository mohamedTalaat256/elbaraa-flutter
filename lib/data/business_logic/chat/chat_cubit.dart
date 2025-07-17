import 'package:elbaraa/data/business_logic/dio_error_handeler.dart';
import 'package:elbaraa/data/models/ChatMessage.dart';
import 'package:elbaraa/data/models/chat.dart';
import 'package:elbaraa/data/models/requests/app_response.dart';
import 'package:elbaraa/data/repository/chats_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository chatRepository;

  List<Chat> chats = [];
  List<ChatMessage> chatMessages = [];
  ChatCubit(this.chatRepository) : super(ChatInitial());

  Future<List<Chat>> getAuthUserChat() async {
    emit(ChatsLoading());

    try {
      AppResponse<List<Chat>> response = await chatRepository.getAuthUserChat();
      emit(ChatsLoaded(response.data!));
      return response.data!;
    } on DioException catch (e) {
      emit(ChatLoadingFialState(DioErrorHandler.decodeErrorResponse(e)));
      return [];
    }
  }

  List<ChatMessage> getChatMessages(int secondPersonId) {
    chatRepository.getChatMessages(secondPersonId).then((chatMessages) {
      emit(ChatMessagesLoaded(chatMessages));
      this.chatMessages = chatMessages;
    });
    return chatMessages;
  }
}
