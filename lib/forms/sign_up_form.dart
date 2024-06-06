import 'package:flutter/material.dart';

import 'package:flutter_sign_up/components/password_hints.dart';
import 'package:flutter_sign_up/components/common_button.dart';
import 'package:flutter_sign_up/components/common_text_input.dart';
import 'package:flutter_sign_up/style/app_colors.dart';
import 'package:flutter_sign_up/utils/validation.dart';
import 'package:flutter_sign_up/utils/types.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late bool validEmail = false;
  late bool isPasswordValid = false;
  late List<String> passwordErrors = [];
  String? errorText;

  @override
  void initState() {
    super.initState();
  }

  void _validateEmail(String value) {
    if (!value.validateIfEmailIsCorrect()) {
      setState(() {
        validEmail = false;
        errorText = 'Email is invalid';
      });
    } else {
      setState(() {
        validEmail = true;
        errorText = null;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _validateEmail(_emailController.text);

      if (validEmail && isPasswordValid && passwordErrors.isEmpty) {
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                    title: const Text('Success'),
                    content: const Text('Sign Up successfull'),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () => {Navigator.pop(context, 'OK')},
                          child: const Text('OK'))
                    ]));
      }
    }
  }

  String? _validatePassword(String? value) {
    if (value!.length <= 8) {
      if (!passwordErrors.contains(errorTypesMap['characters'])) {
        setState(() {
          String item = errorTypesMap['characters'].toString();
          passwordErrors.add(item);
        });
      }
    }

    if (value.length > 8) {
      if (passwordErrors.contains(errorTypesMap['characters'])) {
        setState(() {
          var newErrors = passwordErrors
              .where((item) => item != errorTypesMap['characters'])
              .toList();
          passwordErrors = newErrors;
        });
      }
    }

    if (!value.validateUpperLowerCase()) {
      if (!passwordErrors.contains(errorTypesMap['letterCase'])) {
        setState(() {
          String item = errorTypesMap['letterCase'].toString();
          passwordErrors.add(item);
        });
      }
    }

    if (value.validateUpperLowerCase()) {
      if (passwordErrors.contains(errorTypesMap['letterCase'])) {
        setState(() {
          var newErrors = passwordErrors
              .where((item) => item != errorTypesMap['letterCase'])
              .toList();
          passwordErrors = newErrors;
        });
      }
    }

    if (!value.validateHasNumber()) {
      if (!passwordErrors.contains(errorTypesMap['digits'])) {
        setState(() {
          String item = errorTypesMap['digits'].toString();
          passwordErrors.add(item);
        });
      }
    }

    if (value.validateHasNumber()) {
      if (passwordErrors.contains(errorTypesMap['digits'])) {
        setState(() {
          var newErrors = passwordErrors
              .where((item) => item != errorTypesMap['digits'])
              .toList();
          passwordErrors = newErrors;
        });
      }
    }

    if (value.length >= 8 && passwordErrors.isEmpty) {
      setState(() {
        isPasswordValid = true;
      });
    }

    if (value.isEmpty && passwordErrors.isEmpty) {
      setState(() {
        isPasswordValid = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 30),
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.white,
          AppColors.lightBlue2,
        ])),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 140,
              ),
              const Text("Sign up",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff4a4e71))),
              const SizedBox(
                height: 40,
              ),
              CommonTextInput(
                obscureText: false,
                hintText: 'example@email.com',
                controller: _emailController,
                errorText: errorText,
                isInputValid: validEmail,
                onChanged: (value) => {
                  if (value.length == 0)
                    {
                      setState(() {
                        validEmail = false;
                        errorText = null;
                      })
                    }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CommonTextInput(
                obscureText: true,
                hintText: 'Create your password',
                controller: _passwordController,
                validator: _validatePassword,
                onChanged: (text) => {
                  if (text.length == 0)
                    {
                      setState(() {
                        passwordErrors = [];
                        isPasswordValid = false;
                      })
                    }
                },
              ),
              const SizedBox(height: 6),
              PasswordHints(
                isEmailValid: validEmail,
                isPasswordValid: isPasswordValid,
                passwordErrors: passwordErrors,
              ),
              const SizedBox(height: 15),
              CommonButton(
                title: 'Sign up',
                onPressed: _submitForm,
              ),
            ],
          ),
        ));
  }
}
