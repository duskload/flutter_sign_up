import "package:flutter/material.dart";
import "package:flutter/services.dart";

import "package:flutter_sign_up/style/app_colors.dart";

class CommonTextInput extends StatefulWidget {
  final bool obscureText;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String? val)? validator;
  final ValueChanged onChanged;
  final String? errorText;
  final bool? isInputValid;

  const CommonTextInput(
      {super.key,
      required this.obscureText,
      required this.hintText,
      required this.controller,
      this.validator,
      required this.onChanged,
      this.errorText,
      this.isInputValid});

  @override
  State<CommonTextInput> createState() => _CommonTextInputState();
}

class _CommonTextInputState extends State<CommonTextInput>
    with SingleTickerProviderStateMixin {
  bool _hidden = false;

  @override
  void initState() {
    if (widget.obscureText == true) {
      _hidden = true;
    }
    super.initState();
  }

  void _onToggle() {
    setState(() {
      _hidden = !_hidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    var icon = _hidden
        ? const Icon(Icons.visibility_off)
        : const Icon(Icons.remove_red_eye_sharp);
    var suffixIcon = widget.obscureText
        ? IconButton(
            iconSize: 20,
            color: AppColors.borderGrey,
            onPressed: _onToggle,
            icon: icon)
        : null;

    bool enabledInputBorder = (widget.isInputValid == true) && widget.errorText == null;
    var borderColor = enabledInputBorder ? Colors.green : Colors.transparent;

    return Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25),
        child: SizedBox(
          child: TextFormField(
            style: TextStyle(color: enabledInputBorder ? Colors.green : AppColors.borderGrey),
            key: widget.key,
            controller: widget.controller,
            keyboardType: widget.obscureText
                ? TextInputType.text
                : TextInputType.emailAddress,
            obscureText: widget.obscureText ? _hidden : widget.obscureText,
            validator: widget.validator,
            onChanged: widget.onChanged,
            inputFormatters: [
              LengthLimitingTextInputFormatter(64)
            ],
            decoration: InputDecoration(
              errorText: widget.errorText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide:
                BorderSide(color: borderColor, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                   BorderSide(color: borderColor, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: AppColors.borderGrey),
              fillColor: Colors.white,
              filled: true,
              suffixIcon: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 12.0),
                  child: suffixIcon),
            ),
          ),
        ));
  }
}
