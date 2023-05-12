import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nitp_social/enum/view_state.dart';
import 'package:nitp_social/provider/base_view.dart';
import 'package:nitp_social/src/screens/login_screen/bunny.dart';
import 'package:nitp_social/src/widgets/auth_text_field.dart';
import 'package:nitp_social/src/widgets/custom_button.dart';
import 'package:nitp_social/view/home_screen_viewmodel.dart';
import 'package:nitp_social/view/login_screen_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Bunny _bunny;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.stop();
    _bunny = Bunny(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _getTextSize(String text) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
          text: text,
          style: const TextStyle(
            fontSize: 16.0,
          )),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.size.width;
  }

  @override
  Widget build(BuildContext context) {
    final double textFieldWidth = MediaQuery.of(context).size.width - 100;
    return BaseView<LoginViewModel>(builder: (context, model, _) {
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple, Colors.orange],
          ),
        ),
        child: Scaffold(
          key: model.scaffoldKey,
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: model.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.emoji_nature,
                        color: Colors.white,
                        size: 48,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "WallFlower",
                        style: Theme.of(context).textTheme.headline2!.apply(
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Text(
                    "By clicking 'Login', you agree to our Terms of Service and Privacy Policy.",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .apply(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: Lottie.asset(
                      'assets/lottie/bunny_mouth.json',
                      width: 100,
                      height: 100,
                      controller: _controller,
                      fit: BoxFit.fill,
                      onLoaded: (composition) {
                        setState(() {
                          _controller.duration = composition.duration;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  AuthTextField(
                    controller: model.emailController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Email is required";
                      }
                      return null;
                    },
                    labelText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    onHasFocus: (isObscure) {
                      _bunny.setTrackingState();
                    },
                    onChanged: (text) {
                      _bunny
                          .setEyesPosition(_getTextSize(text) / textFieldWidth);
                    },
                  ),
                  const SizedBox(height: 10),
                  AuthTextField(
                    controller: model.passwordController,
                    validator: (String? text) {
                      if (text!.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                    labelText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    onHasFocus: (isObscure) {
                      if (isObscure) {
                        _bunny.setShyState();
                      } else {
                        _bunny.setPeekState();
                      }
                    },
                    onObscureText: (isObscure) {
                      if (isObscure) {
                        _bunny.setShyState();
                      } else {
                        _bunny.setPeekState();
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  model.state == ViewState.idle
                      ? CustomButton(
                          buttonText: 'Sign In',
                          textColor: Colors.white,
                          buttonColor: Theme.of(context).primaryColor,
                          leading: true,
                          onTap: () {
                            if (model.formKey.currentState!.validate()) {
                              model.login();
                            }
                            // Navigator.of(context).pushNamed(Home.routeName);
                          },
                        )
                      : const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
