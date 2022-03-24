class FormartPhone {
  static conver0to84(String phoneNumber) {
    if (phoneNumber[0] == "0") {
      var newValue = phoneNumber.replaceFirst(RegExp(r'0'), "+84");
      return newValue;
    } else {
      return phoneNumber;
    }
  }
}
