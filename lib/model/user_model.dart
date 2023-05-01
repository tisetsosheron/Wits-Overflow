class UserModel {
  String? name;
  String? email;
  String? password;
  String? location;
  String? image;

  UserModel();
  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    location = json['location'];
    image = json['image'];
  }

  get obs => null;
}
