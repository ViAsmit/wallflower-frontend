import 'dart:async';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:nitp_social/provider/base_model.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:nitp_social/services/api_response.dart';
import 'package:nitp_social/services/api_services.dart';
import 'package:nitp_social/src/models/users.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:uuid/uuid.dart';

class ConversationScreenViewModel extends BaseModel {
  List<types.Message> messages = [];
  types.User? user;
  types.User? peeruser;
  User? userdetails;
  User? peeruserdetails;
  String? room;
  late IO.Socket socket;
  late StreamSubscription<bool> keyboardSubscription;
  bool typing = false;

  final ApiService apiService = ApiService();

  Future<void> getUserDetails(String user, String peeruser) async {
    ApiResponse response = await apiService.getRequest(endpoint: 'users/$user');
    print(response.data);
    userdetails = User.fromMap(response.data);

    ApiResponse response2 =
        await apiService.getRequest(endpoint: 'users/$peeruser');
    print(response2.data);
    peeruserdetails = User.fromMap(response2.data);
  }

  void init(String user, String peeruser) async {
    this.user = types.User(id: user);
    this.peeruser = types.User(id: peeruser);

    await getUserDetails(user, peeruser);

    room = this.user!.id.compareTo(this.peeruser!.id) == 1
        ? "${this.user!.id}-${this.peeruser!.id}"
        : "${this.peeruser!.id}-${this.user!.id}";
    print(room);
    await connectRoom();
    var keyboardVisibilityController = KeyboardVisibilityController();

    // Subscribe
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      print('Keyboard visibility update. Is visible: $visible');
      typing = visible;
      notifyListeners();
    });
  }

  void destroy() {
    print("destroy");
    socket.disconnect();
    keyboardSubscription.cancel();
  }

  Future<void> connectRoom() async {
    try {
      socket = IO.io('http://192.168.1.12:5000', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });
      socket.connect();

      // Handle socket events
      socket.on('connect', (msg) {
        print('connect: ${socket.id} $msg');
        socket.emit("room", {
          "room": room,
        });
      });

      socket.on("old_chats", addChats);
      socket.on('message', handleMessage);
    } catch (e) {
      print(e);
      print("=====");
    }
  }

  void addChats(chats) {
    print(chats);

    List<types.Message> msgs = [];
    for (dynamic chat in chats["chats"]) {
      final textMessage = types.TextMessage(
        author: types.User(id: chat["author"]),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: chat["text"],
      );
      msgs.add(textMessage);
    }
    messages = msgs;
    notifyListeners();
  }

  dynamic handleMessage(dynamic msg) {
    print(msg);
    final textMessage = types.TextMessage(
      author: types.User(id: msg["id"]),
      createdAt: msg["timestamp"],
      id: const Uuid().v4(),
      text: msg["message"],
    );

    messages.add(textMessage);
    notifyListeners();
  }

  void sendMessage(String message) {
    socket.emit(
      "message",
      {
        "id": user!.id,
        "message": message, // Message to be sent
        "timestamp": DateTime.now().millisecondsSinceEpoch,
        "room": room,
      },
    );
  }
}
