import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  String? _uid;
  String? _email;
  String? _displayName;
  String? _photoURL;
  late int _points;

  static UserData? _instance;

  static UserData getInstance() {
    UserData._instance ??= UserData._();

    return UserData._instance!;
  }

  UserData._() {
    _points = 0;
  }

  Future<void> _updateSharedPreferences(String key, dynamic value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (value is int) {
      await sharedPreferences.setInt(key, value);
    } else if (value is String) {
      await sharedPreferences.setString(key, value);
    }

    sharedPreferences.reload();
  }

  Future<void> clear() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    _uid = null;
    _email = null;
    _displayName = null;
    _photoURL = null;
    _points = 0;

    sharedPreferences.clear();
  }

  String? get photoURL => _photoURL;

  set photoURL(String? value) {
    _photoURL = value;

    _updateSharedPreferences("photoURL", value);
  }

  String? get displayName => _displayName;

  set displayName(String? value) {
    _displayName = value;

    _updateSharedPreferences("displayName", value);
  }

  String? get email => _email;

  set email(String? value) {
    _email = value;

    _updateSharedPreferences("email", value);
  }

  String? get uid => _uid;

  set uid(String? value) {
    _uid = value;

    _updateSharedPreferences("uid", value);
  }

  int get points => _points;

  set points(int value) {
    _points = value;

    pointsDBUpdate();
    _updateSharedPreferences("points", value);
  }

  void pointsDBUpdate() async {
    //update points in DB
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    final snapshot = await databaseReference
        .child("users/${UserData.getInstance().uid}/points")
        .get();

    if (snapshot.exists) {
      await databaseReference
          .child("users/${UserData.getInstance().uid}")
          .update({"points": points});
    }
  }
}
