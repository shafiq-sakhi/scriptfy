import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

List<ChatRoom> fruitstFromJson(String str) =>
    List<ChatRoom>.from(json.decode(str).map((x) => ChatRoom.fromMap(x)));
class ChatRoom {
  String? id;
  String? roomName;
  String? userId;
  Timestamp? timestamp;

  ChatRoom({this.id,this.roomName,this.userId});

  ChatRoom.fromMap(Map<String,dynamic> map) {
      id = map['id'];
      roomName = map['room_name'];
      userId = map['user_id'];
      timestamp = map['timestamp'];
  }

  toMap() {
    return <String, dynamic>{
      'id' : id,
      'room_name' : roomName,
      'user_id' : userId,
      'timestamp' : timestamp
    };
  }

}

