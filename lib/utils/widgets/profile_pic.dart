import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  String imagePath;

  ProfilePic({
    super.key,
    this.imagePath = "",
  });

  Color imageBorderColor = Colors.greenAccent;
  VoidCallback? onImagePick = () {};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: [
          CircleAvatar(
            // the radius of the image border -> should be greater then the image size border by 10
            radius: 100,
            backgroundColor: imageBorderColor,
            child: CircleAvatar(
              // the radius of the actual image size
              radius: 90,
              // if no image is provided the default image will be shown
              backgroundImage: imagePath.isNotEmpty
                  ? Image.asset(imagePath).image
                  : Image.asset("assets/images/boy.png").image,
            ),
          ),
          Positioned(
            bottom: 1,
            right: 1,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.white),
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(2, 4),
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: IconButton(
                  icon: const Icon(Icons.add_a_photo, color: Colors.black),
                  onPressed: onImagePick, // To be implemented
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
