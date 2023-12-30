class UserData {
  String? _uid;
  String? _email;
  String? _displayName;
  late String _photoURL;

  static UserData? _instance;

  static UserData getInstance() {
    UserData._instance ??= UserData._();

    return UserData._instance!;
  }

  UserData._() {
    _photoURL =
        "https://cdn3.iconfinder.com/data/icons/social-messaging-productivity-6/128/profile-circle2-512.png";
  }

  String get photoURL => _photoURL;

  set photoURL(String value) {
    _photoURL = value;
  }

  String? get displayName => _displayName;

  set displayName(String? value) {
    _displayName = value;
  }

  String? get email => _email;

  set email(String? value) {
    _email = value;
  }

  String? get uid => _uid;

  set uid(String? value) {
    _uid = value;
  }
}
