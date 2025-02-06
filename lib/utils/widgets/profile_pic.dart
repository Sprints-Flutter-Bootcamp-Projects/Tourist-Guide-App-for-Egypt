import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:math';

class ProfilePic extends StatefulWidget {
  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  File? image;

  // function to request persmissions
  Future<void> requestPermissions() async {
    await Permission.camera.request();
    await Permission.photos.request();
  }

  @override
  void initState() {
    super.initState();
    requestPermissions();
    loadImage(); // if there's an image saved, load it
  }

  //load image from shared preferences
  Future<void> loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString("profile_image");
    if (imagePath != null && File(imagePath).existsSync()) {
      setState(() {
        image = File(imagePath);
      });
    }
  }

  //  save image to shared preferences
  Future<void> saveImage(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("profile_image", path);
  }

  // Open Bottom Sheet for Image Options
  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Choose from Gallery"),
                onTap: () {
                  pickImage(context, ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text("Take a Picture"),
                onTap: () {
                  pickImage(context, ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              if (image != null)
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text("Remove Picture"),
                  onTap: () {
                    removeImage();
                    Navigator.pop(context);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  // pick image with image picker
  Future<void> pickImage(BuildContext context, ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile == null) return;

      File tempImage = File(pickedFile.path);
      String newPath = await saveToAppDirectory(tempImage);

      setState(() {
        image = File(newPath);
      });

      saveImage(newPath);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error picking image: $e"),
          ),
        );
      }
    }
  }

  // save image permanently in app directory (workaround as firebase cloud storage is not free)
  Future<String> saveToAppDirectory(File imageFile) async {
    final directory = await getApplicationDocumentsDirectory();
    // create path for image with random number to avoid conflicts
    final imagePath =
        '${directory.path}/profile_pic_${Random().nextInt(10000)}.png';
    final newImage = await imageFile.copy(imagePath);
    return newImage.path;
  }

  // remove image and clear from SharedPreferences
  Future<void> removeImage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("profile_image");
    setState(() {
      image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: [
          CircleAvatar(
            radius: 82,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            child: CircleAvatar(
              radius: 72,
              backgroundImage: image != null ? FileImage(image!) : null,
              child: image == null
                  ? Icon(
                      Icons.person,
                      size: 90,
                      color: Theme.of(context).colorScheme.secondary,
                    )
                  : null,
            ),
          ),
          Positioned(
            bottom: 1,
            right: 1,
            child: GestureDetector(
              onTap: () => showBottomSheet(context),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 2, color: Theme.of(context).primaryColor),
                  shape: BoxShape.circle,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(Icons.add_a_photo,
                      color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
