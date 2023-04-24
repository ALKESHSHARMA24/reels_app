import 'package:flutter/material.dart';
import 'package:reels_app/constants.dart';
import 'package:reels_app/controllers/auth_controller.dart';
import 'package:reels_app/views/screens/auth/login_screen.dart';
import 'package:reels_app/views/widgets/text_input_filed.dart';

class Signup_screen extends StatelessWidget {
  Signup_screen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
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
            const Text('Register',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                )),

            //creating user name textbox
            const SizedBox(
              height: 15,
            ),

            Stack(
              children: [
                const CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage(
                      'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'),
                  backgroundColor: Colors.black,
                ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: () => authController.pickImage(),
                    icon: const Icon(
                      Icons.add_a_photo,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 15,
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _usernamecontroller,
                labelText: 'Username',
                icon: Icons.person,
              ),
            ),

            //crating the email textbox

            const SizedBox(
              height: 15,
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
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _passwordController,
                labelText: 'Password',
                icon: Icons.lock,
                isObscure: true,
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 50,
              decoration: BoxDecoration(
                  color: buttoncolor,
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: InkWell(
                onTap: () => authController.registeruser(
                  _usernamecontroller.text,
                  _emailController.text,
                  _passwordController.text,
                  authController.profilePhoto,
                ),
                child: const Center(
                  child: Text(
                    'Register',
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
                  'Already have an account',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),

                //InkWell work like a link
                InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Loginscreen(),
                    ),
                  ),
                  child: Text(
                    'Login',
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
