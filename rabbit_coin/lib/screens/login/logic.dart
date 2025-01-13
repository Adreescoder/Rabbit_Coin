import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_screen/view.dart';

class Login_screenLogic extends GetxController {
  TextEditingController passCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  var isLoading = false.obs; // Observable for loading state
  var isPasswordHidden = true.obs;
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  String getUserInitials() {
    // Example: Extracting the first character of the name
    String userName = "User Name";
    return userName.isNotEmpty ? userName[0].toUpperCase() : "?";
  }

  Future<void> signUser() async {
    if (passCon.text.isEmpty || emailCon.text.isEmpty) {
      Get.snackbar('Error', 'Some Error occurred');
    }
    isLoading.value = true; // Start loading
    await Future.delayed(Duration(seconds: 2)); // Simulate a login process
    isLoading.value = false; // Stop loading

    // Add your navigation or success logic here
    Get.snackbar("Success", "Login Successful!");
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailCon.text, password: passCon.text);
    if (userCredential != null) {
      Get.snackbar(
        "Successfully", // Title of the snackbar
        "Login Successfully", // Message of the snackbar
        snackPosition: SnackPosition.TOP, // Position of the snackbar
        backgroundColor: Colors.green, // Background color
        colorText: Colors.white, // Text color
        borderRadius: 10, // Optional: Adds rounded corners to the snackbar
        margin: EdgeInsets.all(10), // Optional: Adds margin around the snackbar
      );
      Get.offAll(() => HomeScreenPage());
    }
  }
}
