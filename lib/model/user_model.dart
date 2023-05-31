class UserModel {
  String? name;       // Represents the user's name
  String? email;      // Represents the user's email address
  String? password;   // Represents the user's password
  String? location;   // Represents the user's location
  String? image;      // Represents the URL or path to the user's image

  UserModel();        // Default constructor for the UserModel class

  // Constructor to create a UserModel object from a JSON map
  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];           // Retrieves the 'name' field value from the JSON map
    email = json['email'];         // Retrieves the 'email' field value from the JSON map
    password = json['password'];   // Retrieves the 'password' field value from the JSON map
    location = json['location'];   // Retrieves the 'location' field value from the JSON map
    image = json['image'];         // Retrieves the 'image' field value from the JSON map
  }

  get obs => null;  // This getter method returns null. It might be an incomplete or placeholder implementation.
}

