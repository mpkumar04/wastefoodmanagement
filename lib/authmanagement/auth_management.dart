import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance; 
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up method
  Future<String?> signUp({
    required String email,
    required String name, 
    required String password, 
    required String role,
    required String phno,
    }) async {
      try {
      // Create user in Firebase Authentication with email and password
      UserCredential userCredential =
        await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Save additional user data (name, role) in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name.trim(),
        'email': email.trim(),
        'password': password.trim(),
        'role': role, // Role determines if user is Admin or User
      });

      return null; // Success: no error message
    } catch (e) {
      return e.toString(); // Error: return the exception message
    }
  }

  // Function to handle user login
  Future<String?> login({
  required String email,
  required String password,
  }) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        return "Email or password cannot be empty";
      }

      // Sign in the user using Firebase Authentication
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Debugging: print user credentials
      print("User successfully logged in: ${userCredential.user!.email}");

      // Fetch the user's role from Firestore to determine access level
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      // Debugging: print the document data to inspect the role
      print("User document data: ${userDoc.data()}");

      if (userDoc.exists) {
        // Fetch the role from Firestore and trim any potential spaces
        var role = (userDoc['role'] as String).trim().toLowerCase();  // Normalize role to lowercase

        // Debugging: print the role fetched from Firestore
        print("User role fetched from Firestore: $role");

        // Compare the role correctly (case insensitive)
        if (role == "ngo" || role == "donor") {
          return role;  // Return valid role
        } else {
          return "Invalid role: $role";  // Handle invalid role
        }
      } else {
        return "User document not found.";  // Document doesn't exist
      }
    } catch (e) {
      print("Login error: $e");  // Debugging print
      return "Login error: $e";  // Return the exception message
    }
  }

}

