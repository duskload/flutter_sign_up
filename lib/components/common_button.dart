import 'package:flutter/material.dart';
import 'package:flutter_sign_up/style/app_colors.dart';

class CommonButton extends StatefulWidget {
  final String title;
  final Function onPressed;
  const CommonButton({super.key, required this.title, required this.onPressed});

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> with SingleTickerProviderStateMixin {
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    ),
  );

  @override
  void initState() {
    super.initState();
  }

  void _onPress() {
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 240,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [AppColors.lightBlue, AppColors.darkBlue]),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: ElevatedButton(
        style: raisedButtonStyle,
        onPressed: _onPress,
        child: Text(widget.title, style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w800,
          color: Colors.white
        )),
      ),
    );
  }
}
