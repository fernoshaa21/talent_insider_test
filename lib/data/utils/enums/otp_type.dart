enum OtpType {
  mail,
  phone;

  String get value => toString().split('.').last.toUpperCase();
}
