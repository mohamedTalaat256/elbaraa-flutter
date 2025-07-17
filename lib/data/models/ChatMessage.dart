// ignore_for_file: unnecessary_null_comparison

class ChatMessage {
  String? id, message, name, avatar, created_at;
  int? sender_id;

  ChatMessage({
    required this.id,
    required this.message, 
    required this.name, 
    required this.sender_id, 
    required this.avatar,
    required this.created_at,
  });

  ChatMessage.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    id = map['id'].toString();
    message = map['message'];
    name = map['name'];
    sender_id = map['sender_id'];
    avatar = map['avatar'];
    created_at = map['created_at'];
  }

  toJson() {
    return {
      'id': id,
      'message': message,
      'name': name,
      'sender_id': sender_id,
      'avatar': avatar,
      'created_at': created_at,
    };
  }
}
