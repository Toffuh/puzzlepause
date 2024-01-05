class User {
  String name;
  int points;

  User(this.name, this.points);

  @override
  String toString() {
    return 'User{_name: $name, _points: $points}';
  }


}