import 'package:flutter/material.dart';
import 'package:nitp_social/enum/view_state.dart';
import 'package:nitp_social/provider/base_view.dart';
import 'package:nitp_social/view/complete_profile_screen_viewmodel.dart';

class AddPhotosScreen extends StatefulWidget {
  const AddPhotosScreen({Key? key}) : super(key: key);

  @override
  State<AddPhotosScreen> createState() => _AddPhotosScreenState();
}

class _AddPhotosScreenState extends State<AddPhotosScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseView<CompleteProfileViewModel>(builder: (context, model, _) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const LinearProgressIndicator(
                value: 1,
                minHeight: 5.0,
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  IconButton(
                    iconSize: 35.0,
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.grey,
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 20.0),
                  Text(
                    "Add Photos",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ],
              ),
              const SizedBox(height: 50.0),
              Text(
                "Add at least 2 photos to continue!",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(height: 50.0),
              Wrap(
                children: [
                  ImageCard(model, index: 0),
                  ImageCard(model, index: 1),
                  ImageCard(model, index: 2),
                  ImageCard(model, index: 3),
                  ImageCard(model, index: 4),
                  ImageCard(model, index: 5),
                ],
              ),
              const SizedBox(height: 50.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: model.state == ViewState.busy
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: model.topics.length < 3
                              ? null
                              : () async {
                                  await model.submitProfile();
                                },
                          child: const Text(
                            "LETS GO!",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class ImageCard extends StatelessWidget {
  final int index;
  final CompleteProfileViewModel model;
  const ImageCard(
    this.model, {
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        print("ok");
        model.pickImage(index);
      },
      child: Card(
        child: SizedBox(
          width: 100.0,
          height: 150.0,
          child: model.state == ViewState.busy
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : model.images[index] == ""
                  ? const Center(
                      child: Icon(Icons.add),
                    )
                  : Image.network(
                      model.images[index],
                      fit: BoxFit.cover,
                    ),
        ),
      ),
    );
  }
}
