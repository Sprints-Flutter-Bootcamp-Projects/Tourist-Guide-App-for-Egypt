// filepath: /d:/Sprints/Module 2/Tourist-Guide-App-for-Egypt/lib/views/government/landmark_page.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tourist_guide/app_drawer.dart';
import 'package:tourist_guide/models/governorate_model.dart';
import 'package:tourist_guide/utils/widgets/lang_dialog.dart';

class LandmarkPage extends StatefulWidget {
  final Governorate governorate;
  const LandmarkPage({super.key, required this.governorate});

  @override
  _LandmarkPageState createState() => _LandmarkPageState();
}

class _LandmarkPageState extends State<LandmarkPage> {
  late ScrollController _scrollController;
  bool _isAppBarExpanded = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _isAppBarExpanded = _scrollController.hasClients &&
              _scrollController.offset > (250 - kToolbarHeight);
        });
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (details) => Navigator.pop(context),
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 250.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  tr(widget.governorate.governorate),
                  style: TextStyle(
                    color: _isAppBarExpanded
                        ? Theme.of(context).colorScheme.onSurface
                        : Colors.white,
                  ),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      widget.governorate.governorateImage,
                      fit: BoxFit.cover,
                    ),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: <Color>[
                            Color(0x80000000), // Black with 50% opacity
                            Color(0x00000000), // Transparent
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                collapseMode: CollapseMode.pin,
              ),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.language),
                  onPressed: () => langDialog(context),
                ),
              ],
              foregroundColor: _isAppBarExpanded
                  ? Theme.of(context).colorScheme.onSurface
                  : Colors.white,
            ),
            SliverPadding(
              padding:
                  const EdgeInsets.only(left: 24.0, right: 24.0, top: 16.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final landmark = widget.governorate.landmarks[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.teal[100]!),
                          borderRadius: BorderRadius.circular(8),
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                tr(landmark.name),
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(tr(landmark.location)),
                            ),
                            Image.network(landmark.image),
                            ListTile(
                              subtitle: Text(tr(landmark.description)),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: widget.governorate.landmarks.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
