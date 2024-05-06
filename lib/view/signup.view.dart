import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:simpan_pinjam/view/widgets/button.global.dart';
import 'package:simpan_pinjam/view/widgets/socialLogin.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _dio = Dio();
  final _apiUrl = 'https://mobileapis.manpits.xyz/api/register';
  // Boolean to determine whether the checkbox is checked or not
  bool agreeToTerms = false;
  // Boolean to determine whether the password text is hidden or not
  bool isObscure = true;

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _signUp(BuildContext context) async {
    // Validate all fields
    String username = usernameController.text.trim();
    String email = emailController.text.trim();
    String phoneNumber = phoneNumberController.text.trim();
    String password = passwordController.text.trim();

    if (username.isNotEmpty &&
        email.isNotEmpty &&
        phoneNumber.isNotEmpty &&
        password.isNotEmpty &&
        agreeToTerms) {
      try {
        // Make HTTP POST request to sign up endpoint
        final response = await _dio.post(
          _apiUrl,
          data: {
            'name': username,
            'email': email,
            'password': password,
          },
        );

        // Check if the response is successful
        if (response.statusCode == 200) {
          // Navigate to the login page if sign up is successful
          Navigator.pop(context);
        } else {
          // Display error message if sign up fails
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Sign up failed. Please try again.'),
            ),
          );
        }
      } catch (error) {
        // Display error message if there's an error with the HTTP request
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred. Please try again later.'),
          ),
        );
      }
    } else {
      // Display error message if any field is empty or terms not agreed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields and agree to the terms.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Text(
                "Let's Create Your Account",
                style: TextStyle(fontSize: 24.0),
              ),
              const SizedBox(height: 32.0),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        labelText: "Username",
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: phoneNumberController,
                      decoration: const InputDecoration(
                        labelText: "Phone Number",
                        prefixIcon: Icon(Icons.phone),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock),
                        // Icon button that toggles the visibility of the password
                        suffixIcon: IconButton(
                          icon: Icon(
                            isObscure ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            // Toggles the password visibility state
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                        ),
                      ),
                      // Determines whether the password text is obscured or not
                      obscureText: isObscure,
                    ),
                    const SizedBox(height: 16.0),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      value: agreeToTerms,
                      onChanged: (bool? value) {
                        setState(() {
                          agreeToTerms = value ?? false;
                        });
                      },
                      title: const Text(
                        "I agree to the privacy policy and terms of use",
                        style: TextStyle(fontSize: 12.0), // set font size here
                      ),
                      dense: true, // make the checkbox smaller
                    ),
                    const SizedBox(height: 10),
                    ButtonGlobal(
                      text: 'Sign Up',
                      onPressed: () =>
                          _signUp(context), // Call sign-up function
                    ),
                    const SizedBox(height: 25),
                    SocialLogin(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
