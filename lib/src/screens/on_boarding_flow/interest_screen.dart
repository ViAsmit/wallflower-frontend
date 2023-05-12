import 'package:flutter/material.dart';
import 'package:nitp_social/enum/view_state.dart';
import 'package:nitp_social/provider/base_view.dart';
import 'package:nitp_social/view/complete_profile_screen_viewmodel.dart';

class InterestTopicsScreen extends StatefulWidget {
  const InterestTopicsScreen({Key? key}) : super(key: key);

  @override
  State<InterestTopicsScreen> createState() => _InterestTopicsScreenState();
}

class _InterestTopicsScreenState extends State<InterestTopicsScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseView<CompleteProfileViewModel>(
      builder: (context, model, _) {
        List<Widget> chips = model.alltopics.map((topic) {
          return GestureDetector(
            onTap: () {
              model.addTopic(topic);
            },
            child: Chip(
              label: Text(topic),
              backgroundColor: model.topics.contains(topic)
                  ? Theme.of(context).primaryColor
                  : Colors.grey[300],
              labelStyle: TextStyle(
                color:
                    model.topics.contains(topic) ? Colors.white : Colors.black,
              ),
            ),
          );
        }).toList();

        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                const LinearProgressIndicator(
                  value: 0.75,
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
                      "Interests",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Let everyone know what you'ar passionate about by adding it to your profile",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                const SizedBox(height: 40.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Wrap(
                    spacing: 10,
                    children: chips,
                  ),
                ),
                const SizedBox(height: 40.0),
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
                                : () {
                                    Navigator.pushNamed(context, "/add-photos");
                                  },
                            child: Text(
                              "CONTINUE ${model.topics.length} / 5",
                              style: const TextStyle(
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
      },
    );
  }
}
