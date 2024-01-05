class User {
  String name;
  String uid;
  int points;

  User(this.name, this.uid, this.points);

  @override
  String toString() {
    return 'User{name: $name, uid: $uid, points: $points}';
  }
}