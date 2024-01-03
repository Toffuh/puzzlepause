class User {
  String _name;
  int _points;

  User(this._name, this._points);

  int get points => _points;

  set points(int value) {
    _points = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  @override
  String toString() {
    return 'User{_name: $_name, _points: $_points}';
  }
}