class User {
  final int id;
  final int age;
  final String firstname;
  final String lastName;
  final String userName;

  User(this.id, this.age, this.firstname, this.lastName, this.userName);

  User.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.age = json['age'],
        this.firstname = json['firstName'],
        this.lastName = json['lastName'],
        this.userName = json['userName'];
}
