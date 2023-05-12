import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nitp_social/provider/base_view.dart';
import 'package:nitp_social/services/prefs_services.dart';
import 'package:nitp_social/src/models/users.dart';
import 'package:nitp_social/view/all_chats_screen_viewmodel.dart';

class AllChatsScreen extends StatefulWidget {
  const AllChatsScreen({super.key});

  @override
  State<AllChatsScreen> createState() => _AllChatsScreenState();
}

class _AllChatsScreenState extends State<AllChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseView<AllChatsScreenViewModel>(
      onModelReady: (model) => model.init(),
      builder: (context, model, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('All Chats'),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: model.users.map((user) => ChatTile(user)).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ChatTile extends StatelessWidget {
  final User user;
  const ChatTile(
    this.user, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        final Prefs prefs = Prefs();
        // String user = await prefs.getAuthUID();
        String user = await prefs.getAuthUID();
        String peeruser = this.user.id!;
        print(user);
        print(peeruser);
        Navigator.pushNamed(
          context,
          '/conversation',
          arguments: {
            'user': user,
            'peeruser': peeruser,
          },
        );
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(
          user.images![0],
        ),
      ),
      title: Text(user.name!),
      subtitle: const Text('Hello'),
      trailing: const Text('12:00'),
    );
  }
}
