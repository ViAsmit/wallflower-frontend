import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:nitp_social/provider/base_view.dart';
import 'package:nitp_social/view/conversation_screen_viewmodel.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class ConverstationScreen extends StatefulWidget {
  final dynamic args;
  const ConverstationScreen(this.args, {Key? key}) : super(key: key);

  @override
  State<ConverstationScreen> createState() => _ConverstationScreenState();
}

class _ConverstationScreenState extends State<ConverstationScreen> {
  late StreamSubscription<bool> keyboardSubscription;

  @override
  Widget build(BuildContext context) {
    return BaseView<ConversationScreenViewModel>(
      onModelReady: (model) =>
          model.init(widget.args["user"], widget.args["peeruser"]),
      onModelDisposed: (model) => model.destroy(),
      builder: (context, model, _) {
        return Scaffold(
          appBar: AppBar(
            leadingWidth: 40,
            title: ListTile(
              minLeadingWidth: 5,
              leading: model.peeruserdetails != null
                  ? CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          NetworkImage(model.peeruserdetails!.images![0]),
                    )
                  : null,
              title: Text(model.peeruserdetails?.name ?? ""),
              subtitle: Text(
                model.typing == true ? "Typing..." : "Online",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.green,
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: Chat(
              messages: model.messages.reversed.toList(),
              onAttachmentPressed: () {},
              onMessageTap: (context, message) {
                print("typing");
                // setState(() {
                //   model.messages.add(message);
                // });
              },
              onSendPressed: (message) {
                model.sendMessage(message.text);
              },
              user: model.user!,
            ),
          ),
        );
      },
    );
  }
}
