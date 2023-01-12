
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import 'package:signalr_client/screens/chat/widgets/message.dart';
import 'package:signalr_client/screens/sign_up/sign_up_controller.dart';
import 'package:signalr_client/screens/sign_up/sign_up_state.dart';
import 'package:signalr_client/screens/sign_up/widgets/pick_image_button.dart';
// import '/core/constants/constants.dart';
import '/core/dependency_injection.dart';
import 'sign_up_controller.dart';


class SignUpView extends StatelessWidget {
  final SignUpController myController = getIt<SignUpController>();

  SignUpView({Key? key}) : super(key: key);





  @override
  Widget build(BuildContext context) {
    SignUpState state = context.watch<SignUpState>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
          //todo test without center
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Please enter your name",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 150,
                  margin: const EdgeInsets.only(top: 10),
                  child: TextField(
                    style: const TextStyle(decoration: TextDecoration.none, color: Colors.white, fontWeight: FontWeight.bold),
                    controller: myController.nameController,
                    decoration: InputDecoration(

                     contentPadding: const EdgeInsets.all(15),
                      hintText: 'Enter user name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),

                    ),
                  ),
                ),
                Container(
                  width: 200,
                  height: 200,
                  child: state.image == null ? Icon(Icons.camera_alt, size: 80,) : Image.file(state.image!),
                ),
                PickImageButton(icon: Icons.image_search, title: "pick image from gallery",
                    onclick: ()=> myController.pickImage(ImageSource.gallery), width: MediaQuery.of(context).size.width - 150),

                Container(
                  width: MediaQuery.of(context).size.width - 200,
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: () => myController.sendContactName(),
                    style: TextButton.styleFrom(),
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}