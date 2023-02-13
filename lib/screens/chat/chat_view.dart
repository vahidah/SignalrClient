import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messaging_signalr/messaging_signalr.dart';
import 'package:provider/provider.dart';
import 'package:signalr_client/screens/chat/widgets/message.dart';

import '../../core/util/funcions.dart';
import '/core/constants/ui.dart';
import '/core/dependency_injection.dart';
import 'chat_controller.dart';
import 'chat_state.dart';

class ChatView extends StatelessWidget {
  final ChatController myController = getIt<ChatController>();
  final SignalRMessaging signalRMessaging = getIt<SignalRMessaging>();
  ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatState state = context.watch<ChatState>();
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  myController.bachToHomeScreen();
                },
                icon: const Icon(Icons.arrow_back, color: ProjectColors.fontWhite),
              ),
              title: InkWell(
                onTap: () => myController.myNavigator.snackBar(Text("contact id is: ${signalRMessaging.selectedChat!.chatId}")),
                child: Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(10),
                        height:40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: ProjectColors.fontWhite,
                            borderRadius: BorderRadius.circular(20)
                          //more than 50% of width makes circle
                        ),
                        child: signalRMessaging.selectedChat!.image == null ?FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(firstTwoChOfName(signalRMessaging.selectedChat!.userName ?? signalRMessaging.selectedChat!.chatId), style: const TextStyle(color: ProjectColors.projectBlue),),
                        ) : Image.memory(base64.decode(signalRMessaging.selectedChat!.image!))),
                    const SizedBox(width: 10,),
                    Text(
                      signalRMessaging.selectedChat!.userName?? signalRMessaging.selectedChat!.chatId,
                      style: const TextStyle(fontSize: 20, color: ProjectColors.fontWhite),
                    ),
                  ],
                ),
              )),
          body:
              // myController.homeState.rebuildChatList.value;
              Stack(
            children: [
              Image.asset(
                "assets/images/chatbackwhatsapp.png",
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              Column(
                children: [
                  Expanded(
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height - 140,
                        child: ListView(
                          shrinkWrap: true,
                          children: signalRMessaging.selectedChat!.messages.map((e) {
                            return MessageWidget(
                              clientMessage: e.sender == signalRMessaging.myId,
                              chatType: signalRMessaging.selectedChat!.type,
                              message: e,
                            );
                          }).toList(),
                        ),
                      ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 55,
                          child: Card(
                            margin: const EdgeInsets.only(left: 2, right: 2, bottom: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              minLines: 1,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: IconButton(
                                    icon: const Icon(Icons.emoji_emotions),
                                    onPressed: () {},
                                  ),
                                  suffixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.attach_file),
                                        padding: EdgeInsets.zero,
                                      ),
                                      state.textController.text == ""
                                          ? IconButton(
                                          onPressed: () {
                                            if (state.textController.text == "") {
                                              debugPrint("what is this");
                                            }
                                          },
                                          icon: const Icon(Icons.camera_alt),
                                          padding: EdgeInsets.zero)
                                          : const SizedBox(
                                        height: 0,
                                        width: 0,
                                      )
                                    ],
                                  ),
                                  contentPadding: const EdgeInsets.all(10),
                                  hintText: "Message"),
                              controller: state.textController,
                              onChanged: (str) => myController.textControllerChanged(str),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2, right: 2, bottom: 8),
                          child: CircleAvatar(
                            radius: 25,
                            child: state.textController.text == ""
                                ? IconButton(onPressed: () {}, icon: const Icon(Icons.mic))
                                : IconButton(
                                onPressed: () => myController.sendMessage(signalRMessaging.selectedChat!.type == ChatType.contact),
                                icon: const Icon(Icons.send)),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
