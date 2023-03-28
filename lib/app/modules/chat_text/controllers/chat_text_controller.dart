import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:text_to_image/models/chat.dart';
import 'package:text_to_image/services/data_services.dart';
import '../../../common/headers.dart';
import '../../../model/text_completion_model.dart';

class ChatTextController extends GetxController {
  //TODO: Implement ChatTextController
  dynamic argumentData = Get.arguments;
  late String roomId;
  late bool isStory;

  @override
  void onInit() async{
    roomId = argumentData[0]['room_id'];
    isStory = argumentData[0]['is_story'];
    print(isStory);
    print('room id  ---------- '+argumentData[0]['room_id']);
    super.onInit();
  }

  @override
  void onReady(){
    getMessagesFromFirebase();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  List<TextCompletionData> messages = <TextCompletionData>[].obs;

  var state = ApiState.notFound.obs;

  getMessagesFromFirebase() async{
    List<Chat> chats = await getChats(roomId);

    if(chats.isNotEmpty){
      for(var chat in chats){
        if(chat.from == 0){
          messages.insert(0, await myMessage(chat.chatText!));
        }else if(chat.from == 1){
          addServerMessage(
              TextCompletionModel.fromJson(json.decode(utf8.decode(chat.chatText!.runes.toList()))).choices);
        }
      }
    }
  }

  getTextCompletion(String query) async {
    addMyMessage();

    state.value = ApiState.loading;

    try {
      Map<String, dynamic> rowParams = {
        "model": "text-davinci-003",
        "prompt": query,
        "max_tokens": 100,
      };

      final encodedParams = json.encode(rowParams);

      final response = await http.post(
        Uri.parse(endPoint("completions")),
        body: encodedParams,
        headers: headerBearerOption('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'),
      );
      print("Response  body     ${response.body}");
      if (response.statusCode == 200) {
        if(roomId != "0"){
          await addChat(Chat(chatText: response.body,from: 1,roomId: roomId));
        }
        addServerMessage(
            TextCompletionModel.fromJson(json.decode(utf8.decode(response.bodyBytes))).choices);
        state.value = ApiState.success;
      } else {
        state.value = ApiState.error;
      }
    } catch (e) {
      print("Errorrrrrrrrrrrrrrr  ");
    } finally {
      // searchTextController.clear();
      update();
    }
  }

  addServerMessage(List<TextCompletionData> choices) {
    for (int i = 0; i < choices.length; i++) {
      messages.insert(i, choices[i]);
    }
  }

  addMyMessage() async{
    // {"text":":\n\nWell, there are a few things that you can do to increase","index":0,"logprobs":null,"finish_reason":"length"}
    TextCompletionData text = await myMessage(searchTextController.text);
    messages.insert(0, text);
    if(roomId != "0"){
      await addChat(Chat(chatText: text.text,from: 0,roomId: roomId));
    }
  }

  Future<TextCompletionData> myMessage(String myText) async{
    TextCompletionData text = TextCompletionData(
        text: myText, index: -999999, finish_reason: "");
    return text;
  }

  TextEditingController searchTextController = TextEditingController();
}