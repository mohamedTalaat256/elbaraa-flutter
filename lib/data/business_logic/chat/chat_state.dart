part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatsLoaded extends ChatState {
  final List<Chat> chats;
  ChatsLoaded(this.chats);
}

class ChatsLoading extends ChatState {}

class ChatLoadingFialState extends ChatState {
  final String message;
  ChatLoadingFialState(this.message);
}

class ChatMessagesLoaded extends ChatState {
  final List<ChatMessage> chatMessages;
  ChatMessagesLoaded(this.chatMessages);
}

class SendingMessageLoadingState extends ChatState {}

class MessageSendSuccessState extends ChatState {}

class MessageSendFailState extends ChatState {
  final String message;

  MessageSendFailState({required this.message});
}
