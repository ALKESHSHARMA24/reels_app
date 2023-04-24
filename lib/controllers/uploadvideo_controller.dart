import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:reels_app/constants.dart';
import 'package:reels_app/models/video.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  //compress the video size
  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.HighestQuality,
    );
    return compressedVideo!.file;
  }

  //get the video path for video in string type
  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('videos').child(id);

    UploadTask uploadTask = ref.putFile(await _compressVideo(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  //get the thumbnail for video in string
  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // upload video
  uploadVideo(String songName, String caption, String videoPath) async {
    // try {
    String uid = firebaseAuth.currentUser!.uid;
    DocumentSnapshot userDoc =
        await firestore.collection('users').doc(uid).get();

    //get id
    var allDocs = await firestore.collection('videos').get();
    int len = allDocs.docs.length;
    String videoUrl = await _uploadVideoToStorage("Video $len", videoPath);
    String thumbnail = await _uploadImageToStorage("Video $len", videoPath);
    Video video = Video(
      //HERE THE USERNAME,PROFILEPICS DATA TAKEN AS MAP DATA BECAUSE WE FETCH THIS DATA FROM THE FIREBASE
      // SO WHAT NAME THIS VARAIBLE WAS STORE IN FIREBASE USE THE SAME NAME HERE
      
      username: (userDoc.data()! as Map<String, dynamic>)['name'],
      uid: uid,
      id: "Video $len",
      likes: [],
      commentCount: 0,
      shareCount: 0,
      songName: songName,
      caption: caption,
      videoUrl: videoUrl,
      profilepics: (userDoc.data()! as Map<String, dynamic>)['profilepics'],
      thumbnail: thumbnail,
    );

    await firestore.collection('videos').doc("Video $len").set(
          video.toJson(),
        );
    Get.back();
    // } catch (e) {
    // Get.snackbar('Error Uploading Video', e.toString());
    // }
  }
}
