// ignore_for_file: constant_identifier_names

class UserModel{
  static const String COLLECTION_NAME = "Users";
  String id,name,email;
  int age;

  UserModel({this.id="",required this.name,required this.email,required this.age});

  UserModel.fromJSON(Map<String, dynamic> json)
      : this(
    //id: json['id'],
    name: json['name'],
    email: json['email'],
    age: json['age'],
  );

  Map<String, dynamic> toJSON() {
    return {
      //"id": id,
      "name": name,
      "email": email,
      "age": age,
    };
  }
}