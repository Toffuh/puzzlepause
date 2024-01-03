import 'package:firebase_database/firebase_database.dart';

class UserData {
  String? _uid;
  String? _email;
  String? _displayName;
  late String _photoURL;
  late int _points;

  static UserData? _instance;

  static UserData getInstance() {
    UserData._instance ??= UserData._();

    return UserData._instance!;
  }

  UserData._() {
    _photoURL =
        "https://cdn3.iconfinder.com/data/icons/social-messaging-productivity-6/128/profile-circle2-512.png";
    _points = 0;
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

  int get points => _points;

  set points(int value) {
    _points = value;

    pointsDBUpdate();
  }

  void pointsDBUpdate() async {
    //update points in DB
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    final snapshot = await databaseReference
        .child("users/${UserData.getInstance().uid}/points")
        .get();

    if (snapshot.exists) {
      if (points > int.parse(snapshot.value.toString())) {
        await databaseReference
            .child("users/${UserData.getInstance().uid}")
            .update({"points": points});
      }
    }
  }

  void addToSharedPreferences() {

  }
}
