import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tourist_guide/widgets/app_bar.dart';

class LandmarkPage extends StatelessWidget {
  final String governorateName;
  final List<dynamic> landmarks;
  const LandmarkPage(
      {super.key, required this.governorateName, required this.landmarks});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (details) => Navigator.pop(context),
      child: Scaffold(
        appBar: PagesAppBar(context, tr(governorateName)),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Text(
                tr('landmarks'),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.teal[800],
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 16);
                  },
                  itemCount: landmarks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.teal[100]!),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.teal[50],
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(tr(landmarks[index]['name']),
                                style: TextStyle(
                                    color: Colors.teal[900],
                                    fontWeight: FontWeight.bold)),
                            subtitle: Text(tr(landmarks[index]['location'])),
                          ),
                          Image.network(landmarks[index]['image']),
                          ListTile(
                            subtitle: Text(tr(landmarks[index]['description'])),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
