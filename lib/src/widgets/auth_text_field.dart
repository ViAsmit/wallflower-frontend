import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.onHasFocus,
    this.onObscureText,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  final String labelText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final validator;

  final Function(bool isObscure)? onHasFocus;

  final Function(bool isObscure)? onObscureText;

  final Function(String text)? onChanged;

  @override
  AuthTextFieldState createState() => AuthTextFieldState();
}

class AuthTextFieldState extends State<AuthTextField> {
  bool _isObscure = true;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_refresh);
  }

  void _refresh() {
    if (_focusNode.hasFocus && widget.onHasFocus != null) {
      widget.onHasFocus?.call(_isObscure);
    }
    setState(() {});
  }

  @override
  void dispose() {
    _focusNode.removeListener(_refresh);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(8.0),
      height: 60.0,
      child: Listener(
        onPointerDown: (e) => FocusScope.of(context).requestFocus(_focusNode),
        child: TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          focusNode: _focusNode,
          style: Theme.of(context).textTheme.button!.apply(
                color: Colors.black,
              ),
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            fillColor: Color(0xFF30444E),
            contentPadding: new EdgeInsets.symmetric(vertical: 12),
            border: InputBorder.none,
            prefixIcon: Prefix(),
            hintText: widget.labelText,
            hintStyle: Theme.of(context).textTheme.button!.apply(
                  color: Colors.black,
                ),
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                      if (widget.onObscureText != null) {
                        widget.onObscureText?.call(_isObscure);
                      }
                    },
                  )
                : null,
          ),
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText ? _isObscure : widget.obscureText,
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}

Widget Prefix() {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Icon(
      Icons.person,
      color: Color(0xFFFFC542),
    ),
  );
}
