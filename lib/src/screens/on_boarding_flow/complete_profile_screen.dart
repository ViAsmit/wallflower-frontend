import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nitp_social/provider/base_view.dart';
import 'package:nitp_social/view/complete_profile_screen_viewmodel.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({Key? key}) : super(key: key);

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseView<CompleteProfileViewModel>(
      builder: (context, model, _) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LinearProgressIndicator(
                    value: 0.5,
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
                        "Complete Profile",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Form(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        // shrinkWrap: true,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Full Name",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          TextFormField(
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .apply(color: Theme.of(context).primaryColor),
                            controller: model.nameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your full name";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            "Date of Birth",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .apply(
                                          color:
                                              Theme.of(context).primaryColor),
                                  controller: model.dobController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter your date of birth";
                                    }
                                    return null;
                                  },
                                  readOnly: true,
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              IconButton(
                                onPressed: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2050),
                                  ).then((date) {
                                    if (date != null) {
                                      model.dobController.text =
                                          DateFormat('dd/MMM/yyyy')
                                              .format(date);
                                    }
                                  });
                                },
                                icon: const Icon(Icons.date_range),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            "Gender",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GenderCard(
                                img:
                                    "https://img.freepik.com/premium-vector/blue-male-gender-symbol_465506-92.jpg",
                                label: "Male",
                                group: model.gender,
                                onChange: (val) => model.changeGender(val),
                              ),
                              GenderCard(
                                img:
                                    "https://t3.ftcdn.net/jpg/02/26/65/56/360_F_226655618_EExdf2WAWwDx4LzPi5OZmfG5li88v4f0.jpg",
                                label: "Female",
                                group: model.gender,
                                onChange: (val) => model.changeGender(val),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Interested In",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GenderCard(
                                img:
                                    "https://img.freepik.com/premium-vector/blue-male-gender-symbol_465506-92.jpg",
                                label: "Male",
                                group: model.interest,
                                onChange: (val) => model.changeInterest(val),
                              ),
                              GenderCard(
                                img:
                                    "https://t3.ftcdn.net/jpg/02/26/65/56/360_F_226655618_EExdf2WAWwDx4LzPi5OZmfG5li88v4f0.jpg",
                                label: "Female",
                                group: model.interest,
                                onChange: (val) => model.changeInterest(val),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/topics");
                              },
                              child: const Text(
                                "SAVE & CONTINUE",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class GenderCard extends StatelessWidget {
  GenderCard({
    Key? key,
    required this.img,
    required this.label,
    required this.group,
    required this.onChange,
  }) : super(key: key);
  String img;
  String label;
  String group;
  Function onChange;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Image.network(
              img,
              height: 100.0,
              width: 100.0,
            ),
            // const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Radio(
                  activeColor: Theme.of(context).primaryColor,
                  value: label,
                  groupValue: group,
                  onChanged: (val) {
                    onChange(val);
                  },
                ),
                Text(label),
              ],
            )
          ],
        ),
      ),
    );
  }
}
