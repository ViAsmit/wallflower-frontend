import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final bool? leading;
  final VoidCallback onTap;
  const CustomButton(
      {Key? key,
      required this.buttonText,
      required this.buttonColor,
      required this.textColor,
      this.leading,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return // Figma Flutter Generator Sign_buttonWidget - INSTANCE
        InkWell(
      onTap: onTap,
      child: Container(
          width: 315,
          height: 58,
          decoration: BoxDecoration(
            color: Theme.of(context).buttonTheme.colorScheme!.secondary,
            borderRadius: BorderRadius.circular(12),
            // boxShadow: const [
            //   BoxShadow(
            //       color: Color.fromRGBO(15, 218, 136, 0.3),
            //       offset: Offset(0, 2),
            //       blurRadius: 4)
            // ],
            // gradient: LinearGradient(
            //     begin: Alignment(0, 1),
            //     end: Alignment(-1, 0),
            //     colors: [
            //       Color.fromRGBO(63, 223, 158, 1),
            //       Color.fromRGBO(62, 213, 152, 1)
            //     ]),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: textColor, fontSize: 20),
                ),
                const SizedBox(
                  width: 30,
                ),
                leading == true
                    ? Icon(
                        FontAwesomeIcons.arrowRight,
                        color: textColor,
                        size: 17,
                      )
                    : SizedBox(),
              ],
            ),
          )),
    );
  }
}
