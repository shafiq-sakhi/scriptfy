import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

List<Chat> fruitstFromJson(String str) =>
    List<Chat>.from(json.decode(str).map((x) => Chat.fromMap(x)));
class Chat {
  String? id;
  String? chatText;
  int? from;
  Timestamp? timestamp;
  String? roomId;

  Chat({this.id,this.chatText,this.from,this.roomId});

  Chat.fromMap(Map<String,dynamic> map) {
      id = map['number'];
      chatText = map['chat_text'];
      from = map['from'];
      timestamp = map['timestamp'];
      roomId = map['room_id'];
  }

  toMap() {
    return <String, dynamic>{
      'id' : id,
      'chat_text': chatText,
      'from': from,
      'timestamp' : timestamp,
      'room_id': roomId
    };
  }

}

