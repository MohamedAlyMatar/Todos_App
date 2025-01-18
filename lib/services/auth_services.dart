import 'package:dio/dio.dart';

class AuthService {
  final String loginEndpoint = "https://dummyjson.com/auth/login";
  final String usersEndpoint = "https://dummyjson.com/users";

  // Function to sign in a user
  // Future<List<Map<String, dynamic>>> signIn(
  //     String username, String password) async {
  //   try {
  //     print("Signing in");
  //     try {
  //       var response = await fetchUserAndValidate(username, password);
  //       if (response == null) {
  //         print("User not found or invalid password");
  //       }
  //     } catch (e) {
  //       print("Error during user validation: ${e.toString()}");
  //     }
  //     var response = await Dio().post(
  //       loginEndpoint,
  //       data: {"username": username, "password": password},
  //     );
  //     print("Sign-in successful: ${response.data}");
  //     return [response.data];
  //   } catch (e) {
  //     print("Error during sign-in: ${e.toString()}");
  //     return [];
  //   }
  // }

  Future<List<Map<String, dynamic>>> signIn(
      String username, String password) async {
    try {
      print("Signing in");
      var user = await fetchUserAndValidate(username, password);
      if (user == null) {
        print("User not found or invalid credentials");
        return []; // Return an empty list to indicate failure
      }
      var response = await Dio().post(
        loginEndpoint,
        data: {"username": username, "password": password},
      );
      print("Sign-in successful: ${response.data}");
      return [response.data];
    } catch (e) {
      print("Error during sign-in: ${e.toString()}");
      return [];
    }
  }

  // Function to fetch all users and validate username/password
  Future<Map<String, dynamic>?> fetchUserAndValidate(
      String username, String password) async {
    try {
      print("Fetching users...");
      var response = await Dio().get(usersEndpoint);
      List<dynamic> users = response.data['users'];

      // Find user by username
      var user = users.firstWhere(
        (user) => user['username'] == username,
        orElse: () => null,
      );

      if (user != null) {
        if (user['password'] == password) {
          print("User authenticated: ${user['firstName']} ${user['lastName']}");
          return user;
        } else {
          print("Password mismatch for username: $username");
        }
      } else {
        print("Username not found: $username");
      }
    } catch (e) {
      print("Error fetching users: ${e.toString()}");
    }
    return null;
  }
}
