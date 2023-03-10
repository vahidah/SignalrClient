
import 'dart:core';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:signalr_client/screens/new_contact/new_contact_state.dart';
import 'package:signalr_core/signalr_core.dart';


import 'package:signalr_client/core/constants/constant_values.dart';
import '../constants/apis.dart';
import '../dependency_injection.dart';
import '../../screens/home/home_state.dart';
import '../../screens/chat/chat_state.dart';
import '../classes/chat.dart';
import '../classes/message.dart';



void define_signalr_functions(){

  HubConnection connection = getIt<HubConnection>();
  HomeState myHomeState = getIt<HomeState>();
  ChatState myChatState = getIt<ChatState>();
  NewContactState newContactState = getIt<NewContactState>();



  connection.on('ReceiveNewMessage', (message) async{
    debugPrint("new message received");
    int targetIndex = myHomeState.chats.indexWhere((e) => e.chatName == message![0].toString());
    if(targetIndex != -1){
      myHomeState.chats[targetIndex].messages.add( Message(sender: message![0], text: message[1], senderUserName: message[2]));
      myHomeState.chats.insert(0, myHomeState.chats[targetIndex]);
      myHomeState.chats.removeAt(targetIndex + 1);
      myChatState.setState();
    }else{
      debugPrint("send request to get image");
      Map<String, String> requestHeaders = {
        "Connection": "keep-alive",
      };
      http.Response response = await http.post(
          Uri.parse("${Apis.getImage}/${message![0]}",),
          headers: requestHeaders

      );
      debugPrint("image received");
      final base64Image = base64.encode(response.bodyBytes);
      myHomeState.chats.insert(0, Chat(type: ChatType.contact, chatName: message[0].toString(), messages:
      [Message(sender: message[0], text: message[1], senderUserName: message[2],)],userName: message[2],
      image: base64Image),);
      // myHomeState.rebuildChatList.toggle();
    }

    debugPrint("new message received from ${message[0]}");
    debugPrint(message[1]);
  });
  connection.on('receiveUserName', (message){
    debugPrint("user name is : ${message![1]}");
    int targetChat = myHomeState.chats.indexWhere((element) => element.chatName == message[0].toString());
    myHomeState.chats[targetChat].userName = message[1];
    debugPrint("receive user name");
    // newContactState.userNameReceived.toggle();
    // myHomeState.rebuildChatList.toggle();
  });

  connection.on('GroupMessage', (message) {
    debugPrint("new message for group ${message![0]} form user ${message[1]} received, message is ${message[2]}");
    debugPrint(message[1].toString());
    int targetIndex = myHomeState.chats.indexWhere((e) => e.chatName == message[0]);
    if(targetIndex != -1){
      myHomeState.chats[targetIndex].messages.add(Message(sender: message[1], text: message[2], senderUserName: message[3]));
      myHomeState.chats.insert(0, myHomeState.chats[targetIndex]);
      myHomeState.chats.removeAt(targetIndex + 1);
      myChatState.setState();
    }else{
      debugPrint("here1");
      myHomeState.chats.insert(0, Chat(type: ChatType.contact, chatName: message[0].toString(), messages:
      [Message(sender: message[1], text: message[2], senderUserName: message[3]),]));
      // myHomeState.rebuildChatList.toggle();
    }

  });

  connection.on('ReceiveId', (message) {
    ConstValues.myId = message![0];
    debugPrint("client id is ${ConstValues.myId}");
    connection.invoke('ReceiveFireBaseToken', args: [ConstValues.fireBaseToken]);
    debugPrint("connection status:  ${connection.state}");
    debugPrint("sending token");
    // myHomeState.idReceived.toggle();
  });

}