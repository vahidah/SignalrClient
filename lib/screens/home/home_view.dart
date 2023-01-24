import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:signalr_client/core/classes/chat.dart';
import 'package:signalr_client/screens/chat/widgets/message.dart';
import 'dart:convert';

// import '/core/constants/constants.dart';
import '/core/dependency_injection.dart';
// import '/widgets/LoadingWidget.dart';
// import '/widgets/my_app_bar.dart';
import 'home_controller.dart';
import 'home_state.dart';
// import '../widgets/drawer_widget.dart';
// import '../widgets/home_header.dart';
// import '../widgets/home_list_widget.dart';

class HomeView extends StatelessWidget {
  final HomeController myController = getIt<HomeController>();

  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeState state = context.watch<HomeState>();
    return SafeArea(
        child: Scaffold(

      appBar: AppBar(
        // bottom: TabBar(
        //   tabs: tabs,
        //   controller: tabController,
        // ),
        //   leading: IconButton(
        //     onPressed: () {
        //       myController.bachToHomeScreen();
        //     },
        //     icon: Icon(Icons.arrow_back, color: Colors.white),
        //   ),
        title: Text(
          "My Id is ${myController.homeState.myId}",
          style: const TextStyle(fontSize: 20, color: Colors.white),
          //todo move color to ui constants
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ))
        ],
      ),
      body:

          Obx(() {
        debugPrint("rebuild this chat");
        myController.homeState.imageIndex = 0;
        myController.homeState.rebuildChatList.value;
        return ListView(
          shrinkWrap: true,
          children: [
            ...myController.homeState.chats.map((e) {
              debugPrint("user name is : ${e.userName}");
              myController.homeState.imageIndex++;
              return TextButton(
                onPressed: () => myController.goToChatScreen(e.chatName),
                child: Container(
                  height: 60,
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(
                      width: 1.0,
                      color: Colors.black54,
                      style: BorderStyle.solid
                    ))
                  ),
                  child: Row(

                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CircleAvatar(
                          backgroundImage: MemoryImage(base64.decode(e.image!)),
                          radius: 25,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(e.userName?? e.chatName, style: const TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Colors.black),),
                            ),
                            Text(e.messages.isNotEmpty ? "${e.messages[0].senderUserName} : ${e.messages[0].text}" : "",
                              style: const TextStyle(color: Colors.black54,),
                            ),

                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                "19:54",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }).toList()
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => myController.goToNewChatScreen(),
        child: const Icon(Icons.chat),
      ),

    ),

    );
  }
}
