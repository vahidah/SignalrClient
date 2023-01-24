import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '/core/classes/airline_class.dart';
// import '/core/classes/flight_element_class.dart';
// import '/core/classes/flight_status_class.dart';
// import '/core/classes/home_notif_class.dart';
// import '/core/classes/login_class.dart';
// import '/core/classes/notif_class.dart';
// import '/core/classes/notif_type_class.dart';
// import '/core/util/moon_icons.dart';
// import '/core/util/utils.dart';

class ChatState with ChangeNotifier {
  setState() => notifyListeners();


  int myId = -1;
  String? chatKey;

  TextEditingController textController = TextEditingController();



  List<MapEntry<String, List<Map<int, String>>>> chats = [];
  RxBool rebuildChatList = false.obs;
  RxBool idReceived = false.obs;
  RxBool showSendMessageIcon = false.obs;
}