import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/chat.dart';
import '../models/chat_room.dart';
final db = FirebaseFirestore.instance;

Future addChat(Chat chat) async {
  var newDocRef = db.collection('chats').doc();
   chat.id = newDocRef.id;
   chat.timestamp = Timestamp.fromDate(DateTime.now());
   newDocRef.set(chat.toMap());
}

Future addChatRoom(ChatRoom chatRoom) async {
  var newDocRef = db.collection('chat_rooms').doc();
  chatRoom.id = newDocRef.id;
  chatRoom.timestamp = Timestamp.fromDate(DateTime.now());
  newDocRef.set(chatRoom.toMap());
}

Future<List<ChatRoom>> getChatRooms(String userId) async {
  List<ChatRoom> rooms = [];
  var collection = db.collection('chat_rooms').orderBy('timestamp', descending: true);
  var querySnapshot = await collection.where("user_id", isEqualTo: userId).get();
  for(var queryDoc in querySnapshot.docs){
    Map<String, dynamic> map = queryDoc.data();
    rooms.add(ChatRoom.fromMap(map));
  }
  return rooms;
}

Future<List<Chat>> getChats(String roomId) async {
  List<Chat> chats = [];
  var collection = db.collection('chats').where("room_id", isEqualTo: roomId)
      .orderBy('timestamp', descending: false);
  var querySnapshot = await collection.get();

  for(var queryDoc in querySnapshot.docs){
    Map<String, dynamic> map = queryDoc.data();
    chats.add(Chat.fromMap(map));
  }

  return chats;
}

Future incrementStars() async{
  await db.collection("users")
      .doc(FirebaseAuth.instance.currentUser?.uid ?? "")
      .set({"stars": FieldValue.increment(20)}, SetOptions(merge: true));
}

Future deleteChats(String id) async{
  await db.collection('chats').where('room_id', isEqualTo: id).get().then((value) async{
    for(var doc in value.docs){
      await doc.reference.delete();
    }
  });
  await db.collection('chat_rooms').doc(id).delete();
}
