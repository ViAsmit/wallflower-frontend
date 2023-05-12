import 'package:flutter/material.dart';

class AppRules extends StatefulWidget {
  const AppRules({Key? key}) : super(key: key);

  @override
  State<AppRules> createState() => _AppRulesState();
}

class _AppRulesState extends State<AppRules> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const LinearProgressIndicator(
              value: 0.25,
              minHeight: 5.0,
            ),
            Row(
              children: [
                IconButton(
                  iconSize: 35.0,
                  icon: const Icon(Icons.close),
                  color: Colors.grey,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            const Icon(
              Icons.emoji_nature,
              size: 50.0,
            ),
            const SizedBox(height: 10.0),
            Text(
              "Welcome To WallFlower!",
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 10.0),
            Text(
              "Please read these House Rules",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                children: [
                  const Icon(Icons.check),
                  const SizedBox(width: 10.0),
                  Text(
                    "Be Yourself",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                "Make sure your photos, age, and boi are true to who yo are.",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                children: [
                  const Icon(Icons.check),
                  const SizedBox(width: 10.0),
                  Text(
                    "Stay Safe",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                "Don't be too quick to give out personal information.",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                children: [
                  const Icon(Icons.check),
                  const SizedBox(width: 10.0),
                  Text(
                    "Play it cool",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                "Respect others and treat them as you would like to be treated",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                children: [
                  const Icon(Icons.check),
                  const SizedBox(width: 10.0),
                  Text(
                    "Be proactive",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Always report bad behaviour",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text(
                    "CONTINUE",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () =>
                      Navigator.pushNamed(context, "/complete-profile"),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
