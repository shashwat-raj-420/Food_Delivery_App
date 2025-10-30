import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/my_button.dart';
import 'package:food_delivery_app/components/my_textfield.dart';
import 'package:food_delivery_app/services/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final void Function() onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void register() async {
    // get the suth service
    final authService = AuthService();

    //check if passowrds match -> create user
    if (passwordController.text == confirmPasswordController.text) {
      // try create user
      try {
        await authService.signUpWithEmailPassword(
          emailController.text,
          passwordController.text,
        );
      }
      // display any errors
      catch (e) {
        showDialog(
          context: context.mounted ? context : throw Exception(),
          builder: (context) => AlertDialog(title: Text(e.toString())),
        );
      }
    }
    // if passwords dont match -> show error
    else {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(title: Text("Passwords don't match!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            Icon(
              Icons.lock_open_rounded,
              size: 100,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),

            const SizedBox(height: 25),

            // message, app slogan
            Text(
              "Lets create an account for you",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),

            const SizedBox(height: 25),

            // email textfeild
            MyTextfield(
              controller: emailController,
              hintText: "email",
              obscureText: false,
            ),

            const SizedBox(height: 25),

            // password textfeild
            MyTextfield(
              controller: passwordController,
              hintText: "password",
              obscureText: true,
            ),

            const SizedBox(height: 25),

            // confirm password textfeild
            MyTextfield(
              controller: confirmPasswordController,
              hintText: "confirm password",
              obscureText: true,
            ),

            const SizedBox(height: 25),

            // signup button
            MyButton(
              text: "sign up",
              onTap: () {
                register();
              },
            ),

            const SizedBox(height: 25),

            //already a member? login here now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "already a member?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                const SizedBox(width: 4),

                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    "login here",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
