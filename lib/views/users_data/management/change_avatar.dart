import 'package:flutter/material.dart';

class AvatarsList extends StatelessWidget {
  final Function(String) onAvatarUpdate;
  AvatarsList({super.key, required this.onAvatarUpdate});

  final List<String> avatarsUrlList = [
    'https://avatar.iran.liara.run/public/boy',
    'https://avatar.iran.liara.run/public/girl',
    'https://avatar.iran.liara.run/public/job/police/male',
    'https://avatar.iran.liara.run/public/job/police/female',
    'https://avatar.iran.liara.run/public/job/doctor/male',
    'https://avatar.iran.liara.run/public/job/doctor/female'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Avatar'),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: avatarsUrlList.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            onAvatarUpdate(avatarsUrlList[index]);
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Image.network(avatarsUrlList[index]),
          ),
        ),
      ),
    );
  }
}
