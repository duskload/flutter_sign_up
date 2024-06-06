import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sign_up/style/app_colors.dart';
import 'package:flutter_sign_up/utils/types.dart';

class PasswordHints extends StatefulWidget {
  final bool isEmailValid;
  final List<String> passwordErrors;
  final bool isPasswordValid;

  const PasswordHints(
      {super.key,
      required this.isEmailValid,
      required this.passwordErrors,
      required this.isPasswordValid});

  @override
  State<PasswordHints> createState() => _PasswordHintsState();
}

class _PasswordHintsState extends State<PasswordHints>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var hasPasswordType = widget.passwordErrors.isNotEmpty;
    var hasCharactersError =
        widget.passwordErrors.contains(errorTypesMap['characters']);
    var hasDigitsError =
        widget.passwordErrors.contains(errorTypesMap['digits']);
    var hasCaseError =
        widget.passwordErrors.contains(errorTypesMap['letterCase']);

    var charactersColor = hasPasswordType
        ? hasCharactersError
            ? Colors.red
            : Colors.green
        : AppColors.text;
    var digitsColor = hasPasswordType
        ? hasDigitsError
            ? Colors.red
            : Colors.green
        : AppColors.text;
    var caseColor = hasPasswordType
        ? hasCaseError
            ? Colors.red
            : Colors.green
        : AppColors.text;
    return Padding(
        padding:
            const EdgeInsets.only(left: 25.0, right: 25.0, top: 15, bottom: 15),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25, bottom: 4),
                child: Text('8 characters or more (no spaces)',
                    style: TextStyle(
                        fontSize: 13,
                        color: widget.isPasswordValid
                            ? Colors.green
                            : charactersColor)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, bottom: 4),
                child: Text('Uppercase and lowercase letters',
                    style: TextStyle(
                        fontSize: 13,
                        color:
                            widget.isPasswordValid ? Colors.green : caseColor)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, bottom: 4),
                child: Text('At least one digit',
                    style: TextStyle(
                        fontSize: 13,
                        color: widget.isPasswordValid
                            ? Colors.green
                            : digitsColor)),
              ),
            ],
          ),
        ));
  }
}
