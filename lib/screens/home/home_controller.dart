
import 'dart:core';
import 'package:get/get.dart';
import 'package:signalr_core/signalr_core.dart';

import '../chat/chat_state.dart';
import '/core/constants/route_names.dart';
import '/core/dependency_injection.dart';
import '/core/interfaces/controller.dart';
import 'home_state.dart';








class HomeController extends MainController {
  final HomeState homeState = getIt<HomeState>();
  final ChatState chatState = getIt<ChatState>();
  final HubConnection connection = getIt<HubConnection>();






  void goToChatScreen(String chatKey){

    chatState.chatKey = (chatKey).obs;
    myNavigator.goToName(RouteNames.chat);
  }
  void goToNewChatScreen(){
    myNavigator.goToName(RouteNames.newChat);
  }





}
