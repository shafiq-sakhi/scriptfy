import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text_to_image/app/routes/app_pages.dart';
import 'package:text_to_image/constants/constants.dart';
import 'package:text_to_image/models/chat_room.dart';
import 'package:text_to_image/services/data_services.dart';
import 'package:text_to_image/utils/app_language.dart';
import 'package:text_to_image/utils/global_functions.dart';
import '../../controller/admin_base_controller.dart';

class CodeCompletion extends StatefulWidget {
  final bool isStory;
  const CodeCompletion({Key? key, required this.isStory}) : super(key: key);

  @override
  State<CodeCompletion> createState() => _CodeCompletionState();
}

class _CodeCompletionState extends State<CodeCompletion> {
  List<ChatRoom> rooms = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  fetchData() async{
    List<ChatRoom> newRooms = widget.isStory ?
    await getStoryChatRooms(AdminBaseController.userData.value.userId!)
        : await getChatRooms(AdminBaseController.userData.value.userId!);
    setState(() {
      rooms.clear();
      rooms.addAll(newRooms);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.pinkLight,
        title: Text(widget.isStory ? AppLanguage.TEXT_COMPLETION : AppLanguage.CODE_COMPLETION_CHATS),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.only(top: 10),
                itemCount: rooms.length,
                itemBuilder: (context,index){
                  ChatRoom room = rooms[index];
                  return InkWell(
                    onTap: (){
                      Get.toNamed(Routes.CHAT_TEXT, arguments: [{
                        "room_id" : room.id,"is_story" : widget.isStory}]);
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 5,left: 5,right: 5),
                      padding: EdgeInsets.only(right: 10, left: 15,top: 12,bottom: 12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey.withOpacity(0.2))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${room.roomName!}', style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),),
                                ],
                              )],
                          ),
                          PopupMenuButton(
                              onSelected: (v)  {
                                if(v == 1) {
                                 showConfirmation(
                                     context: context,
                                     text: AppLanguage.DO_YOU_REALLY_WANT_TO_DELETE,
                                     onPressed: () async{
                                       await deleteChats(room.id!);
                                       fetchData();
                                       Navigator.pop(context);
                                       showSnackBar(context, AppLanguage.DELETE);
                                     });
                                }
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              itemBuilder: (c) =>[
                                PopupMenuItem(
                                    value: 1,
                                    child: Text(AppLanguage.DELETE_CHATROOM)),
                              ]
                          )
                        ],
                      ),
                    ),
                  );
                }
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.add,size: 40,),
        ),
        onPressed: (){
          newChatRoom();
        },
      ),
    );
  }

  void newChatRoom(){
    TextEditingController txtName;
    txtName = new TextEditingController();
    showCupertinoDialog(
        barrierDismissible: true,
        context: context,
        builder: (context)=> CupertinoAlertDialog(
          content: Material(
            elevation: 0,
            color: Colors.transparent,
            child: Container(
              child: Column(
                children: [
                  Text(AppLanguage.NEW_CHAT,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor),),
                  SizedBox(height: 15,),
                  CupertinoTextField(
                    textAlign: TextAlign.center,
                    controller: txtName,
                    placeholder: AppLanguage.TITLE,
                    autofocus: true,
                    maxLines: null,
                  ),
                  SizedBox(height: 15,),
                  Container(
                    height: 40,
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () async{
                        String name = txtName.text;
                        showLoadingProgress(context);
                        print(AdminBaseController.userData.value.userId);
                        if(name.isNotEmpty){
                          await addStoryChatRoom(ChatRoom(roomName: name,
                              userId: AdminBaseController.userData.value.userId));
                        }
                        fetchData();
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      color: Theme.of(context).primaryColor,
                      child:Text(AppLanguage.ADD,style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }

}
