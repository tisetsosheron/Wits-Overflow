//this class represents a user. It has properties for the user's name, email, password, location, and image.
// It has a constructor to create instances of the class from JSON data, allowing easy mapping of data received from external sources to the class structure.
//
//
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
