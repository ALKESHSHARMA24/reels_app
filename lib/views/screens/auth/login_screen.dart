import 'package:flutter/material.dart';
import 'package:reels_app/constants.dart';
import 'package:reels_app/views/screens/auth/signup_screen.dart';
import 'package:reels_app/views/widgets/text_input_filed.dart';

class Loginscreen extends StatelessWidget {
  Loginscreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Reels app',
                style: TextStyle(
                  fontSize: 35,
                  color: buttoncolor,
                  fontWeight: FontWeight.w900,
                )),
            const Text('Login',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                )),

            //crating the email textbox

            const SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _emailController,
                labelText: 'Email',
                icon: Icons.email,
              ),
            ),

            //crating the password textbox

            const SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _passwordController,
                labelText: 'Password',
                isObscure: true,
                icon: Icons.lock,
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 50,
              decoration: BoxDecoration(
                  color: buttoncolor,
                  borderRadius: const BorderRadius.all(Radius.circular(5))),

              //checking on the login click event passing the email,pass the register user
              child: InkWell(
                onTap: () => authController.loginUser(
                  _emailController.text,
                  _passwordController.text,
                ),
                child: const Center(
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            //registering the user
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),

                //InkWell work like a link
                InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Signup_screen(),
                    ),
                  ),
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 20, color: buttoncolor),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
