// filepath: /D:/Sprints/Module 2/Tourist-Guide-App-for-Egypt/lib/views/government/government_page.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tourist_guide/controllers/governorate_controller.dart';
import 'package:tourist_guide/models/governorate_model.dart';
import 'package:tourist_guide/views/government/landmark_page.dart';
import 'package:tourist_guide/widgets/governorate_list_tile.dart';

class GovernmentPage extends StatelessWidget {
  const GovernmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (BuildContext _) => const GovernmentListPage();
            break;
          case '/landmark':
            final args = settings.arguments as Map<String, dynamic>;
            builder = (BuildContext _) => LandmarkPage(
                  governorate: Governorate.fromJson(args),
                );
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}

class GovernmentListPage extends StatefulWidget {
  const GovernmentListPage({super.key});

  @override
  State<GovernmentListPage> createState() => _GovernmentListPageState();
}

class _GovernmentListPageState extends State<GovernmentListPage> {
  late Future<List<Governorate>> futureGovernorates;

  @override
  void initState() {
    super.initState();
    futureGovernorates = GovernorateController().fetchGovernorates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Governorates'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Governorate>>(
          future: futureGovernorates,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: const Text('No data available'));
            } else {
              final governorates = snapshot.data!;
              return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 16,
                ),
                itemCount: governorates.length,
                itemBuilder: (context, index) {
                  final governorate = governorates[index];
                  return GovernorateListTile(
                    goverorateName: tr(governorate.governorate),
                    onTap: () {
                      Navigator.pushNamed(context, '/landmark', arguments: {
                        'governorate': governorate.governorate,
                        'governorate_image': governorate.governorateImage,
                        'landmarks': governorate.landmarks
                            .map((landmark) => landmark.toJson())
                            .toList(),
                      });
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
