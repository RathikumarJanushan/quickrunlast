import 'package:flutter/material.dart';
import 'package:quickrun/auth/auth_service.dart';
import 'package:quickrun/auth/signup_screen.dart';
import 'package:quickrun/common_widget/round_button.dart';
import 'package:quickrun/view/admin/adminhome_screen.dart';
import 'package:quickrun/view/main_tabview/main_tabview.dart';

import 'package:quickrun/view/user/home_screen.dart';
import 'package:quickrun/widgets/button.dart';
import 'package:quickrun/widgets/textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = AuthService();

  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                const SizedBox(height: 50),
                CustomTextField(
                  hint: "Enter Email",
                  label: "Email",
                  controller: _email,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  hint: "Enter Password",
                  label: "Password",
                  isPassword: true,
                  controller: _password,
                ),
                const SizedBox(height: 30),
                RoundButton(
                  title: "Login",
                  onPressed: _login,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(color: Color.fromARGB(255, 5, 5, 5)),
                    ),
                    InkWell(
                      onTap: () => goToSignup(context),
                      child: const Text(
                        "Signup",
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  goToSignup(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignupScreen()),
      );

  goToHome(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MainTabView()),
      );

  goToAdminHome(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AdminhomeomeScreen()),
      );

  _login() async {
    print("Attempting login with email: ${_email.text}");
    final user =
        await _auth.loginUserWithEmailAndPassword(_email.text, _password.text);

    if (user != null) {
      print("User Logged In: ${user.uid}");

      if (_email.text == "admin@gmail.com") {
        print("Admin logged in");
        goToAdminHome(context);
      } else {
        print("Regular user logged in");
        goToHome(context);
      }
    } else {
      print("Login failed");
    }
  }
}
