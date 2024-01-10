import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:travelplanner/signup.dart';
import 'dart:convert';
import 'package:travelplanner/travel.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorMessage = '';
  bool isLoggedIn = false;
  bool showPassword = false;

  Future<void> login() async {
    try {
      final Uri url = Uri.parse('http://datrik.000webhostapp.com/login.php');

      final response = await http.post(
        url,
        body: {
          'email': usernameController.text,
          'password': passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        final responseData = response.body;

        if (responseData.contains('success')) {
          errorMessage = '';
          isLoggedIn = true;

          String? username= json.decode(responseData)['user_id'].toString();

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Travel(),
            ),
          );
        } else {
          errorMessage = 'Login failed. Please check your username and password.';
        }
      } else {
        errorMessage = 'Server error. Please try again later.';
      }
    } catch (e) {
      errorMessage = 'Network error. Please check your internet connection.';
      print('Exception: $e');
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.teal),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                   labelStyle: TextStyle(color: const Color.fromARGB(255, 3, 70, 5)),
                          prefixIcon: Icon(Icons.lock, color: Color.fromARGB(255, 1, 4, 39)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: const Color.fromARGB(255, 3, 41, 71), width: 2.0),
                            borderRadius: BorderRadius.circular(15.0),
                          )
              ),
            ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.teal),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: const Color.fromARGB(255, 3, 70, 5)),
                          prefixIcon: Icon(Icons.lock, color: Color.fromARGB(255, 1, 4, 39)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: const Color.fromARGB(255, 3, 41, 71), width: 2.0),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              showPassword ? Icons.visibility : Icons.visibility_off,
                              color: Colors.teal,
                            ),
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                          ),
                        ),
                        obscureText: !showPassword,
                      ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              child: Text('Login'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignupScreen(),
      ),
    );
              },
              child: Text("Don't have an account? signup."),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: LoginPage()));
