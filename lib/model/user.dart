import 'dart:convert';
import 'package:http/http.dart' as http;

// User model
class User {
  final String firstName;
  final String lastName;
  final String imageUrl;
  final int age;
  final String gender;
  final String birthDate;


  User({required this.firstName, 
        required this.lastName, 
        required this.imageUrl, 
        required this.age, 
        required this.gender, 
        required this.birthDate
  });

  // Factory constructor to create a User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'],
      lastName: json['lastName'],
      imageUrl: json['image'], 
      age: json['age'], 
      gender: json['gender'], 
      birthDate: json['birthDate'],
    );
  }

 String getFullName(){
  return '$firstName $lastName';
 }
}

// Function to fetch user data from the API
Future<User> fetchUser() async {
  final response = await http.get(Uri.parse('https://dummyjson.com/users/1'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    return User.fromJson(data);
  } else {
    throw Exception('Failed to load user');
  }
}