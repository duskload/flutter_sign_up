
extension Validation on String {
  bool validateUpperLowerCase() {
    RegExp regEx = RegExp(r"(?=.*[a-z])(?=.*[A-Z])\w+");
    return regEx.hasMatch(this);
  }

  bool validateHasNumber() {
    RegExp regEx = RegExp(r"(?=.*[0-9])\w+");
    return regEx.hasMatch(this);
  }

  bool validateIfEmailIsCorrect() {
    return RegExp(r'^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$').hasMatch(this);
  }
}