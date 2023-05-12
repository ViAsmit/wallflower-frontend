import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nitp_social/enum/view_state.dart';
import 'package:nitp_social/provider/base_model.dart';
import 'package:nitp_social/services/api_response.dart';
import 'package:nitp_social/services/api_services.dart';
import 'package:nitp_social/services/prefs_services.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CompleteProfileViewModel extends BaseModel {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  String gender = "Male";
  String interest = "Female";
  List<String> topics = [];
  List<String> alltopics = [
    "Climate Change",
    "Active Lifestyle",
    "Travel",
    "Bollywood",
    "Anime",
    "Ludo",
    "Fashion",
    "Hiking",
    "Cricket",
    "Fishing",
    "Dancing",
    "Maggi",
    "Cooking",
    "Photography",
    "Gaming",
    "Reading",
    "Writing",
    "Singing",
    "Drama",
    "Literature",
    "History",
    "Geography",
    "Street Foods",
    "Blogging"
  ];
  List<String> images = ["", "", "", "", "", ""];
  final ImagePicker picker = ImagePicker();

  void changeGender(String val) {
    gender = val;
    notifyListeners();
  }

  void changeInterest(String val) {
    interest = val;
    notifyListeners();
  }

  void addTopic(String topic) {
    if (topics.contains(topic)) {
      topics.remove(topic);
    } else {
      if (topics.length == 5) return;
      topics.add(topic);
    }
    notifyListeners();
  }

  final Prefs prefs = Prefs();
  final ApiService apiService = ApiService();

  void pickImage(int index) async {
    setState(ViewState.busy);
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      setState(ViewState.idle);
      return;
    }

    String uid = await prefs.getAuthUID();
    Reference ref =
        FirebaseStorage.instance.ref().child("profile_images").child(uid).child(
              "${DateTime.now().millisecondsSinceEpoch}_$index.jpg",
            );

    print("here===================");
    UploadTask uploadTask = ref.putFile(File(pickedFile.path));

    uploadTask.whenComplete(() async {
      print("done");
      images[index] = (await ref.getDownloadURL()).toString();
      notifyListeners();
      print(images);
      setState(ViewState.idle);
    });

    // images[index] = pickedFile.path;
    // notifyListeners();
  }

  Future<void> submitProfile() async {
    setState(ViewState.busy);
    String uid = await prefs.getAuthUID();

    Map<String, dynamic> profile = {
      "_id": uid,
      "name": nameController.text,
      "dob": dobController.text,
      "gender": gender,
      "interest": interest,
      "topics": jsonEncode(topics),
      "images": jsonEncode(images.where((element) => element != "").toList()),
    };
    print(profile);

    final ApiResponse response =
        await apiService.postRequest("/users/profile", profile);

    setState(ViewState.idle);
    print(response.data);
  }
}
