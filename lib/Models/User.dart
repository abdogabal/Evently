class User {
  String? id;
  String? name;
  String? gender;
  String? email;
  int? age;

  User({this.name, this.email, this.age, this.gender, this.id});

  User.fromFireStore(Map<String, dynamic>? data) {
    id = data?["id"];
    name = data?["name"];
    gender = data?["gender"];
    email = data?["email"];
    age = data?["age"];
  }

  Map<String, dynamic> toFireStore() {

    return {
      "id":id,
      "name":name,
      "gender":gender,
      "email":email,
      "age":age
    };
  }
}
