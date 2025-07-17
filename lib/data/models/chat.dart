import 'package:elbaraa/data/models/user.dart';

class Chat {
  final int id;
  final User user;
  final String lastMessage;
  final String lastMessageDate;
  final int isRead;

  Chat({
    required this.id,
    required this.user,
    required this.lastMessage,
    required this.lastMessageDate,
    required this.isRead,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'],
       user: User.fromJson(json['user']),
      lastMessage: json['lastMessage'],
      lastMessageDate: json['lastMessageDate'],
      isRead: json['isRead'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
         'user': user.toJson(),
        'lastMessage': lastMessage,
        'lastMessageDate': lastMessageDate,
        'isRead': isRead,
      };
}
