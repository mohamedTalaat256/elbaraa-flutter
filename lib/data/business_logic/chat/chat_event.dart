import 'package:equatable/equatable.dart';

class ChatEvents extends Equatable{

  @override
  List<Object> get props =>[];
}




class SendMessageButtonPressed extends ChatEvents{

  final String reciver_id;
  final String message;

  SendMessageButtonPressed({
    required this.reciver_id,
    required this.message
  });
}

