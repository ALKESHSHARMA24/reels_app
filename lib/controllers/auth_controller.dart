import 'dart:io';
import 'package:reels_app/controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reels_app/models/user.dart' as model;
import 'package:reels_app/constants.dart';
import 'package:reels_app/views/screens/auth/login_screen.dart';
import 'package:reels_app/views/screens/home_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  User get user => _user.value!;

  //Rx  check that values in the folder was changed or not in firebase

  late Rx<User?> _user;
  late Rx<File?> _pickedImage;

  File? get profilePhoto => _pickedImage.value;

//MANAGING THE STATE

//this method is used to when the user data value will be changed then throw
//on the login screen

  @override
  void onReady() {
    super.onReady();
    //taking the current user value using rx from firebase
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => Loginscreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

//creating the fuction to take photo from the gallary
  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar(
          'Profile Picture', 'You have sucessfully upload the profile picture');
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  //upload the photo of user to the  firebase storage and genrate
  //the link for particualr photo in the firebase storage
  Future<String> _uploadtoStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  //register the user

  void registeruser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        //save out user to our auth and send the data releted to new user to firebase firestore

        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        String downloadUrl = await _uploadtoStorage(image);
        model.User user = model.User(
          email: email,
          name: username,
          uid: cred.user!.uid,
          profilepics: downloadUrl,
        );

        //set the above data to firebase store
        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
      }
      //if user not enter all the fileds details then show the error massage
      else {
        Get.snackbar('Error creating Account', 'please enter the fileds');
      }
    } catch (e) {
      Get.snackbar(
        'Error Creating Account',
        e.toString(),
      );
    }
  }

  //create the function for login the user
  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        print('login sucessfully');
      } else {
        Get.snackbar(
          'Error Logging in',
          'Please enter all the fields',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error Loggin in',
        e.toString(),
      );
    }
  }

  void signOut() async {
    await firebaseAuth.signOut();
  }
}
